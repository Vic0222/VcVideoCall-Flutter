import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/call_listening/call_listening_event.dart';
import 'package:vc_video_call/blocs/call_listening/call_listening_state.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';
import 'package:vc_video_call/services/chat_service.dart';
import 'package:vc_video_call/services/web_rtc_manager.dart';

class CallListeningBloc extends Bloc<CallListeningEvent, CallListeningState> {
  final WebRtcManager _webRtcManager;
  final ChatService _chatService;

  StreamSubscription<JoinResponse> _joinResponseSubscription;

  CallListeningBloc(this._webRtcManager, this._chatService)
      : super(CallListeningState.initial());

  @override
  Stream<CallListeningState> mapEventToState(CallListeningEvent event) async* {
    if (event is CallListningStarted) {
      try {
        await _onStartCallListner(event);
        yield CallListeningState.listeningInProgress();
      } catch (e) {
        yield CallListeningState.failure(e.toString());
      }
    } else if (event is CallListningCallReceived) {
      yield CallListeningState.ringingInProgress(event.callOfferNotification);
    } else if (event is CallListningCallAccepted) {
      _joinResponseSubscription?.cancel();
      await acceptCall(event.withVideo);
      yield CallListeningState.callInProgress(
          event.callOfferNotification, event.withVideo);
    } else if (event is CallListningCallDeclined) {
      await declineCall();
      yield CallListeningState.failure("Call Declined");
    } else {
      yield CallListeningState.initial();
    }
  }

  bool startCallListening() {
    if (state.status == CallListeningStatus.initial ||
        state.status == CallListeningStatus.failure) {
      add(CallListningStarted());
      return true;
    }
    return false;
  }

  Future _onStartCallListner(CallListningStarted event) async {
    _joinResponseSubscription?.cancel();

    _joinResponseSubscription =
        _chatService.joinResponseController.stream.listen((response) {
      if (response.type == JoinResponseType.CallSignaling) {
        add(CallListningCallReceived(response.callOfferNotification));
      }
    });
  }

  @override
  Future close() async {
    super.close();
    _joinResponseSubscription?.cancel();
  }

  Future acceptCall(bool withVideo) async {
    await _webRtcManager.accept(state.callOfferNotification.roomId,
        state.callOfferNotification.rtcSessionDescription, withVideo);
  }

  Future declineCall() async {
    await _webRtcManager.decline(state.callOfferNotification.roomId);
  }
}
