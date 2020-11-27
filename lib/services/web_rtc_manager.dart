import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';
import 'package:vc_video_call/services/chat_service.dart';

typedef PeerConnectionAnswerCallback = void Function(String roomId);
typedef PeerConnectionAnswerConfirmCallback = void Function(String roomId);
typedef PeerConnectionConnectionChangeCallback = void Function(
    RTCPeerConnectionState state, String roomId);

//Single peer connection for now
class WebRtcManager {
  WebRtcManager(this._chatService);

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

    try {
      var stream = await navigator.getUserMedia(mediaConstraints);
      localRenderer.srcObject = stream;
    } catch (e) {
      print(e.toString());
    }
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
    };

    iceCandidates.forEach((candidate) {
      peerConnection.addCandidate(candidate);
    });
    iceCandidates.clear();
  }

  Future call(String roomId) async {
    peerConnections[roomId] = await createPeerConnection(_iceServers, _config);
    await initLocalRenderer();
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

  Future<RTCSessionDescription> answer(
      String roomId, RtcSessionDescription protoOffer) async {
    peerConnections[roomId] = await createPeerConnection(_iceServers, _config);

    await initLocalRenderer();
    await setupPeerConnection(roomId, peerConnections[roomId]);

    var offer = RTCSessionDescription(protoOffer.sdp, protoOffer.type);

    await peerConnections[roomId].setRemoteDescription(offer);
    RTCSessionDescription answer =
        await peerConnections[roomId].createAnswer(_constraints);
    await peerConnections[roomId].setLocalDescription(answer);

    //send answer to server
    var protoAnser = RtcSessionDescription();
    protoAnser.type = answer.type;
    protoAnser.sdp = answer.sdp;
    await _chatService.sendAnswerOffer(roomId, protoAnser);
    onPeerConnectionAnswer?.call(roomId);

    return answer;
  }

  Future confirmAnswer(String roomId, RtcSessionDescription protoAnswer) async {
    var answer = RTCSessionDescription(protoAnswer.sdp, protoAnswer.type);
    await peerConnections[roomId].setRemoteDescription(answer);
    onPeerConnectionAnswerConfirmCallback?.call(roomId);
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
}
