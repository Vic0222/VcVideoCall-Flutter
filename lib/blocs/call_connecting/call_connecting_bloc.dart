import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vc_video_call/blocs/call_connecting/call_connecting_event.dart';
import 'package:vc_video_call/blocs/call_connecting/call_connecting_state.dart';
import 'package:vc_video_call/services/web_rtc_manager.dart';

class CallConnectingBloc
    extends Bloc<CallConnectingEvent, CallConnectingState> {
  final WebRtcManager _webRtcManager;

  CallConnectingBloc(this._webRtcManager)
      : super(CallConnectingState.initial(_webRtcManager.localRenderer)) {
    _webRtcManager.onPeerConnectionConnectionChange =
        (connectionState, roomId) {
      add(CallConnectingConnectionStateChanged(roomId, connectionState));
    };
  }

  @override
  Stream<CallConnectingState> mapEventToState(
      CallConnectingEvent event) async* {
    if (event is CallConnectingConnectionStateChanged) {
      switch (event.connectionState) {
        case RTCPeerConnectionState.RTCPeerConnectionStateConnected:
          yield CallConnectingState.success(
            event.roomId,
            _webRtcManager.localRenderer,
            _webRtcManager.getRemoteRenderer(event.roomId),
          );

          break;
        case RTCPeerConnectionState.RTCPeerConnectionStateDisconnected:
          yield CallConnectingState.failure(
            "Peer connection disconnected.",
            _webRtcManager.localRenderer,
          );

          break;
        case RTCPeerConnectionState.RTCPeerConnectionStateClosed:
          yield CallConnectingState.close(
            _webRtcManager.localRenderer,
          );
          _webRtcManager.close(event.roomId);
          break;
        default:
      }
    } else {
      yield CallConnectingState.initial(_webRtcManager.localRenderer);
    }
  }

  @override
  Future close() async {
    super.close();
  }
}
