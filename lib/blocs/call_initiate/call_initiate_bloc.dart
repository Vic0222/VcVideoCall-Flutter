import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/call_initiate/call_initiate_event.dart';
import 'package:vc_video_call/blocs/call_initiate/call_initiate_state.dart';
import 'package:vc_video_call/services/web_rtc_manager.dart';

class CallInitiateBloc extends Bloc<CallInitiateEvent, CallInitiateState> {
  final WebRtcManager _webRtcManager;

  CallInitiateBloc(this._webRtcManager) : super(CallInitiateState.initial());

  @override
  Stream<CallInitiateState> mapEventToState(CallInitiateEvent event) async* {
    if (event is CallInitiateStarted) {
      //init video camera before calling
      try {
        await _webRtcManager.initLocalRenderer(event.withVideo);
        yield CallInitiateState.inProgress(
            event.roomId, _webRtcManager.localRenderer);
        _onStartCallInitiate(event);
      } catch (e) {
        yield CallInitiateState.failure(e.toString());
        _webRtcManager.close(event.roomId);
      }
    } else if (event is CallInitiateSucceeded) {
      yield CallInitiateState.success(event.roomId);
    } else if (event is CallInitiateFailed) {
      yield CallInitiateState.failure(event.errorMessage);
    } else if (event is CallInitiateCancelled) {
      await _webRtcManager.close(event.roomId);
      yield CallInitiateState.failure("Call cancelled");
    } else {
      yield CallInitiateState.initial();
    }
  }

  void startCallInitiate(String roomId, bool withVideo) {
    add(CallInitiateStarted(roomId, withVideo));
  }

  Future _onStartCallInitiate(CallInitiateStarted event) async {
    try {
      bool success = await _webRtcManager.call(event.roomId);
      if (success) {
        add(CallInitiateSucceeded(event.roomId));
      } else {
        add(CallInitiateFailed(event.roomId, "Unknown"));
      }
    } catch (e) {
      add(CallInitiateFailed(event.roomId, e.toString()));
    }
  }

  @override
  Future close() async {
    super.close();
  }

  void cancelCall(String roomId) {
    add(CallInitiateCancelled(roomId));
  }
}
