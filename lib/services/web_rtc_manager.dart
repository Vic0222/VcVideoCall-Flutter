import 'dart:async';
import 'dart:developer';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';
import 'package:vc_video_call/services/chat_service.dart';

typedef PeerConnectionAnswerCallback = void Function(String roomId);
typedef PeerConnectionAnswerConfirmCallback = void Function(String roomId);
typedef PeerConnectionConnectionChangeCallback = void Function(
    RTCPeerConnectionState state, String roomId);

//Single peer connection for now
class WebRtcManager {
  static WebRtcManager _instance;

  StreamSubscription<JoinResponse> _joinSubscription;

  factory WebRtcManager(ChatService chatService) {
    if (_instance == null) {
      _instance = WebRtcManager._(chatService);
    }
    return _instance;
  }

  WebRtcManager._(this._chatService) {
    _joinSubscription =
        _chatService.joinResponseController.stream.listen((event) {
      if (event.type == JoinResponseType.IceCandidate) {
        receiveIceCandidate(event.iceCandidateNotification.roomId,
            event.iceCandidateNotification.rtcIceCandidate);
      }
    });
  }

  final ChatService _chatService;

  Map<String, RTCPeerConnection> peerConnections =
      Map<String, RTCPeerConnection>();

  PeerConnectionAnswerCallback onPeerConnectionAnswer;
  PeerConnectionConnectionChangeCallback onPeerConnectionConnectionChange;
  PeerConnectionAnswerConfirmCallback onPeerConnectionAnswerConfirmCallback;

  List<RTCIceCandidate> iceCandidates = new List<RTCIceCandidate>();

  RTCVideoRenderer localRenderer = new RTCVideoRenderer();

  Map<String, RTCVideoRenderer> remoteRenderers =
      Map<String, RTCVideoRenderer>();

  Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
      /*
       * turn server configuration example.
      {
        'url': 'turn:123.45.67.89:3478',
        'username': 'change_to_real_user',
        'credential': 'change_to_real_secret'
      },
       */
    ]
  };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ],
  };

  final Map<String, dynamic> _constraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': true,
    },
    'optional': [],
  };

  Future initLocalRenderer() async {
    await localRenderer.initialize();
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'mandatory': {
          'minWidth':
              '640', // Provide your own width, height and frame rate here
          'minHeight': '480',
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': [],
      }
    };

    var stream = await navigator.getUserMedia(mediaConstraints);
    localRenderer.srcObject = stream;
  }

  Future setupPeerConnection(
    String roomId,
    RTCPeerConnection peerConnection,
  ) async {
    var remoteRenderer = RTCVideoRenderer();
    await remoteRenderer.initialize();

    remoteRenderers[roomId] = remoteRenderer;

    peerConnection.onConnectionState = (rtcConnectionState) {
      onPeerConnectionConnectionChange?.call(rtcConnectionState, roomId);
    };

    peerConnection.onAddStream = (stream) {
      remoteRenderer.srcObject = stream;
    };

    peerConnection.addStream(localRenderer.srcObject);

    peerConnection.onIceCandidate = (iceCandidate) {
      //send ice candidate here
      _chatService.sendIceServer(roomId, iceCandidate.candidate,
          iceCandidate.sdpMid, iceCandidate.sdpMlineIndex);
    };

    iceCandidates.forEach((candidate) {
      peerConnection.addCandidate(candidate);
    });
    iceCandidates.clear();
  }

  Future call(String roomId) async {
    peerConnections[roomId] = await createPeerConnection(_iceServers, _config);

    await setupPeerConnection(roomId, peerConnections[roomId]);

    await peerConnections[roomId].createOffer(_constraints).then((value) async {
      await peerConnections[roomId].setLocalDescription(value);
      //send offer to server
      var offer = RtcSessionDescription();
      offer.type = value.type;
      offer.sdp = value.sdp;
      var answer = await _chatService.sendCallOffer(roomId, offer);
      if (answer != null) {
        confirmAnswer(roomId, answer);
      } else {
        throw ("answer confirmation error");
      }
    });
  }

  Future cancel(String roomId) async {
    await peerConnections[roomId].close();
  }

  Future<RTCSessionDescription> accept(
      String roomId, RtcSessionDescription protoAnswer) async {
    peerConnections[roomId] = await createPeerConnection(_iceServers, _config);

    await initLocalRenderer();
    await setupPeerConnection(roomId, peerConnections[roomId]);

    var offer = RTCSessionDescription(protoAnswer.sdp, protoAnswer.type);

    await peerConnections[roomId].setRemoteDescription(offer);
    RTCSessionDescription answer =
        await peerConnections[roomId].createAnswer(_constraints);
    await peerConnections[roomId].setLocalDescription(answer);

    //send answer to server
    var protoAnser = RtcSessionDescription();
    protoAnser.type = answer.type;
    protoAnser.sdp = answer.sdp;
    await _chatService.sendAnswer(roomId, answer: protoAnser);
    onPeerConnectionAnswer?.call(roomId);

    return answer;
  }

  Future decline(String roomId) async {
    await _chatService.sendAnswer(roomId, declined: true);
  }

  Future confirmAnswer(String roomId, RtcSessionDescription protoAnswer) async {
    var answer = RTCSessionDescription(protoAnswer.sdp, protoAnswer.type);
    await peerConnections[roomId].setRemoteDescription(answer);
    onPeerConnectionAnswerConfirmCallback?.call(roomId);
    log("Peer Connection State:" +
        peerConnections[roomId].connectionState.toString());
  }

  void receiveIceCandidate(
    String roomId,
    RtcIceCandidate protoIceCandidate,
  ) {
    var rtcIceCandidate = new RTCIceCandidate(
      protoIceCandidate.candidate,
      protoIceCandidate.sdpMid,
      protoIceCandidate.sdpMlineIndex,
    );

    if (peerConnections.containsKey(roomId)) {
      peerConnections[roomId].addCandidate(rtcIceCandidate);
    } else {
      iceCandidates.add(rtcIceCandidate);
    }
  }

  Future endConnection(String roomId) async {
    await peerConnections[roomId].close();
  }

  RTCVideoRenderer getRemoteRenderer(String roomId) {
    if (remoteRenderers.containsKey(roomId)) {
      return remoteRenderers[roomId];
    }
    return null;
  }
}