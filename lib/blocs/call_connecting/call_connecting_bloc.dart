import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vc_video_call/blocs/call_connecting/call_connecting_event.dart';
import 'package:vc_video_call/blocs/call_connecting/call_connecting_state.dart';
import 'package:vc_video_call/blocs/models/peer_connection_close_event.dart';
import 'package:vc_video_call/services/web_rtc_manager.dart';

class CallConnectingBloc
    extends Bloc<CallConnectingEvent, CallConnectingState> {
  final WebRtcManager _webRtcManager;

  StreamSubscription<PeerConnectionCloseEvent>
      onPeerConnectionCloseStreamSubscriptin;

  CallConnectingBloc(this._webRtcManager)
      : super(CallConnectingState.initial()) {
    _webRtcManager.onPeerConnectionConnectionChange =
        (connectionState, roomId) {
      add(CallConnectingConnectionStateChanged(roomId, connectionState));
    };

    onPeerConnectionCloseStreamSubscriptin =
        _webRtcManager.onPeerConnectionCloseStream.stream.listen((event) {
      //reinitialize();
    });
  }

  @override
  Stream<CallConnectingState> mapEventToState(
      CallConnectingEvent event) async* {
    if (event is CallConnectingStartedEvent) {
      yield CallConnectingState.ready(_webRtcManager.localRenderer);
    } else if (event is CallConnectingConnectionStateChanged) {
      switch (event.connectionState) {
        case RTCPeerConnectionState.RTCPeerConnectionStateConnected:
          var remoteRenderer = _webRtcManager.getRemoteRenderer(event.roomId);
          yield CallConnectingState.success(
            event.roomId,
            _webRtcManager.localRenderer,
            remoteRenderer,
          );

          break;
        case RTCPeerConnectionState.RTCPeerConnectionStateDisconnected:
          yield CallConnectingState.failure(
            "Peer connection disconnected.",
            _webRtcManager.localRenderer,
            _webRtcManager.getRemoteRenderer(event.roomId),
          );

          break;
        case RTCPeerConnectionState.RTCPeerConnectionStateClosed:
          yield CallConnectingState.close(
            _webRtcManager.localRenderer,
            _webRtcManager.getRemoteRenderer(event.roomId),
          );
          _webRtcManager.close(event.roomId);
          break;
        default:
      }
    } else {
      yield CallConnectingState.ready(_webRtcManager.localRenderer);
    }
  }

  @override
  Future close() async {
    super.close();
    onPeerConnectionCloseStreamSubscriptin?.cancel();
  }

  void reinitialize() {
    add(CallConnectingStartedEvent());
  }
}
