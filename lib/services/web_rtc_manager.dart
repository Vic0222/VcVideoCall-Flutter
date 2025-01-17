import 'dart:async';
import 'dart:developer';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vc_video_call/blocs/models/peer_connection_close_event.dart';
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
      } else if (event.type == JoinResponseType.PeerConnectionClose) {
        onPeerConnectionCloseStream.add(PeerConnectionCloseEvent(
            event.peerConnectionCloseNotification.roomId,
            fromServer: true));
        log("PeerConnectionClose recevied");
      }
    });
  }

  final ChatService _chatService;

  Map<String, RTCPeerConnection> peerConnections =
      Map<String, RTCPeerConnection>();

  PeerConnectionAnswerCallback onPeerConnectionAnswer;
  PeerConnectionConnectionChangeCallback onPeerConnectionConnectionChange;
  PeerConnectionAnswerConfirmCallback onPeerConnectionAnswerConfirmCallback;
  StreamController<PeerConnectionCloseEvent> onPeerConnectionCloseStream =
      StreamController<PeerConnectionCloseEvent>.broadcast();

  List<RTCIceCandidate> iceCandidates = new List<RTCIceCandidate>();

  RTCVideoRenderer localRenderer;

  Map<String, RTCVideoRenderer> remoteRenderers =
      Map<String, RTCVideoRenderer>();

  Map<String, dynamic> _iceServers = {
    "iceServers": [
      {
        "urls": [
          "stun:stun.l.google.com:19302",
          "stun:stun1.l.google.com:19302",
          "stun:stun2.l.google.com:19302",
          "stun:stun3.l.google.com:19302",
          "stun:stun4.l.google.com:19302",
        ]
      },
      {
        "urls": [
          "stun:ss-turn2.xirsys.com",
        ]
      },
      {
        "username":
            "Lx8ePfUfQQahi5GCdC3_DVuiI_rl4uQokDc6-OX8xiM4RIosgtdNlph5G2LeujhRAAAAAF_DPhBWaWMwMTEx",
        "credential": "352de696-320b-11eb-ae41-0242ac140004",
        "urls": [
          "turn:ss-turn2.xirsys.com:80?transport=udp",
          "turn:ss-turn2.xirsys.com:3478?transport=udp",
          "turn:ss-turn2.xirsys.com:80?transport=tcp",
          "turn:ss-turn2.xirsys.com:3478?transport=tcp",
          "turns:ss-turn2.xirsys.com:443?transport=tcp",
          "turns:ss-turn2.xirsys.com:5349?transport=tcp"
        ]
      }
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

  Future initLocalRenderer(bool withVideo) async {
    await disposeLocalRenderer();
    if (localRenderer == null) {
      localRenderer = RTCVideoRenderer();
    }
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
    if (!withVideo) {
      stream.getVideoTracks().forEach((track) {
        track.enabled = false;
      });
    }
    localRenderer.srcObject = stream;
  }

  Future disposeLocalRenderer() async {
    localRenderer?.srcObject = null;
    await localRenderer?.dispose();
    localRenderer = null;
  }

  Future setupPeerConnection(
    String roomId,
    RTCPeerConnection peerConnection,
  ) async {
    await disposeRemoteRenderer(roomId);
    var remoteRenderer = RTCVideoRenderer();
    await remoteRenderer.initialize();

    remoteRenderers[roomId] = remoteRenderer;

    peerConnection.onConnectionState = (rtcConnectionState) {
      log("connection state change" + rtcConnectionState.toString());
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
    peerConnection.onIceConnectionState = (rtcIceConnectionState) {
      log("Ice connection change" + (rtcIceConnectionState?.toString() ?? ""));
    };

    iceCandidates.forEach((candidate) {
      peerConnection.addCandidate(candidate);
    });
    iceCandidates.clear();
  }

  Future<bool> call(String roomId) async {
    bool succeeded = false;
    peerConnections[roomId] = await createPeerConnection(_iceServers, _config);

    await setupPeerConnection(roomId, peerConnections[roomId]);

    var offer = await peerConnections[roomId].createOffer(_constraints);
    await peerConnections[roomId].setLocalDescription(offer);
    //send offer to server
    var protooffer = RtcSessionDescription();
    protooffer.type = offer.type;
    protooffer.sdp = offer.sdp;
    var answer = await _chatService.sendCallOffer(roomId, protooffer);
    if (answer != null) {
      confirmAnswer(roomId, answer);
      succeeded = true;
    } else {
      await close(roomId);
      succeeded = false;
    }
    return succeeded;
  }

  Future close(String roomId, {bool shouldCallServer = false}) async {
    //send close signal to prepare ui 1st.
    onPeerConnectionCloseStream
        .add(PeerConnectionCloseEvent(roomId, fromServer: false));
    if (peerConnections.containsKey(roomId)) {
      peerConnections.remove(roomId);
      await peerConnections[roomId]?.close();
      await peerConnections[roomId]?.dispose();
    }

    if (shouldCallServer) {
      _chatService.sendPeerConnectionClose(roomId).catchError((error) {
        //log error but don't do anything
        log(error.toString());
      });
    }
  }

  Future disposeRemoteRenderer(String roomId) async {
    if (remoteRenderers.containsKey(roomId)) {
      remoteRenderers.remove(roomId);
      await remoteRenderers[roomId]?.dispose();
    }
  }

  Future<RTCSessionDescription> accept(
      String roomId, RtcSessionDescription protoAnswer, bool withVideo) async {
    peerConnections[roomId] = await createPeerConnection(_iceServers, _config);

    await initLocalRenderer(withVideo);
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
