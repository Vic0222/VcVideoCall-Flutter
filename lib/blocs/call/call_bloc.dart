import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/call/call_event.dart';
import 'package:vc_video_call/blocs/call/call_state.dart';
import 'package:vc_video_call/services/web_rtc_manager.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final WebRtcManager _webRtcManager;

  CallBloc(this._webRtcManager) : super(CallState.initial());

  @override
  Stream<CallState> mapEventToState(CallEvent event) async* {
    if (event is CallStartedEvent) {
      var peerConnection = _webRtcManager.peerConnections[event.roomId];
      yield CallState.inProgress(
        event.roomId,
        peerConnection,
        this._webRtcManager.localRenderer,
        this._webRtcManager.getRemoteRenderer(event.roomId),
      );
    } else if (event is CallEndedEvent) {
      try {
        event.peerConnection.close();
        _webRtcManager.localRenderer.dispose();
        _webRtcManager.getRemoteRenderer(event.roomId)?.dispose();
      } catch (e) {
        log(e.toString());
      }

      yield CallState.done(event.roomId, event.peerConnection);
    } else if (event is CallAudioToggledEvent) {
      if (state.status == CallStatus.inProgress) {
        bool audioEnabled = _onAudioToggled();
        yield CallState.inProgress(
          state.roomId,
          state.peerConnection,
          state.localRenderer,
          state.remoteRenderer,
          audioEnabled: audioEnabled,
        );
      }
    } else if (event is CallVideoToggledEvent) {
      if (state.status == CallStatus.inProgress) {
        bool videoEnabled = _onVideoToggled();
        yield CallState.inProgress(
          state.roomId,
          state.peerConnection,
          state.localRenderer,
          state.remoteRenderer,
          videoEnabled: videoEnabled,
        );
      }
    } else {
      yield CallState.initial();
    }
  }

  @override
  Future close() async {
    super.close();
  }

  bool _onAudioToggled() {
    bool audioEnabled = !state.audioEnabled;
    state.localRenderer.srcObject.getAudioTracks().forEach((track) {
      track.enabled = audioEnabled;
    });
    return audioEnabled;
  }

  bool _onVideoToggled() {
    bool videoEnabled = !state.videoEnabled;
    state.localRenderer.srcObject.getVideoTracks().forEach((track) {
      track.enabled = videoEnabled;
    });
    return videoEnabled;
  }
}
