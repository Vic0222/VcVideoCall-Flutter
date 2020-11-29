import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vc_video_call/blocs/call/call_connecting_event.dart';
import 'package:vc_video_call/blocs/call/call_connecting_state.dart';
import 'package:vc_video_call/services/web_rtc_manager.dart';

class CallConnectingBloc
    extends Bloc<CallConnectingEvent, CallConnectingState> {
  final WebRtcManager _webRtcManager;

  CallConnectingBloc(this._webRtcManager)
      : super(CallConnectingState.initial()) {
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
        default:
          yield CallConnectingState.failure("Peer connection not connected");
      }
    } else {
      yield CallConnectingState.initial();
    }
  }

  @override
  Future close() async {
    super.close();
  }
}
