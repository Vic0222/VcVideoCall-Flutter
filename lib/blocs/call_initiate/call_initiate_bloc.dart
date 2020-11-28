import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vc_video_call/blocs/call_initiate/call_initiate_event.dart';
import 'package:vc_video_call/blocs/call_initiate/call_initiate_state.dart';
import 'package:vc_video_call/blocs/get_messages/get_messages_event.dart';
import 'package:vc_video_call/services/web_rtc_manager.dart';

class CallInitiateBloc extends Bloc<CallInitiateEvent, CallInitiateState> {
  final WebRtcManager _webRtcManager;

  CallInitiateBloc(this._webRtcManager) : super(CallInitiateState.initial());

  @override
  Stream<CallInitiateState> mapEventToState(CallInitiateEvent event) async* {
    if (event is CallInitiateStarted) {
      try {
        //init video camera before calling
        await _webRtcManager.initLocalRenderer();
        yield CallInitiateState.inProgress(_webRtcManager.localRenderer);
        await _onStartCallInitiate(event);
        yield CallInitiateState.success(event.roomId);
      } catch (e) {
        _webRtcManager.localRenderer.dispose();
        yield CallInitiateState.failure(e.toString());
      }
    } else if (event is CallInitiateCancelled) {
      await _webRtcManager.cancel(event.roomId);
    } else {
      yield CallInitiateState.initial();
    }
  }

  void startCallInitiate(String roomId) {
    add(CallInitiateStarted(roomId));
  }

  Future _onStartCallInitiate(CallInitiateStarted event) async {
    return await _webRtcManager.call(event.roomId);
  }

  @override
  Future close() async {
    super.close();
  }
}
