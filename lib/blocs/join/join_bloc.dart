import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/join/join_event.dart';
import 'package:vc_video_call/blocs/join/join_state.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';
import 'package:vc_video_call/services/chat_service.dart';

class JoinBloc extends Bloc<JoinEvent, JoinState> {
  StreamSubscription<String> _errorStreamSubscription;
  StreamSubscription<JoinResponse> _joinResponseStreamSubscription;

  JoinBloc(this._chatService) : super(JoinState.initial()) {
    add(JoinEvent.joinStarted);
    _errorStreamSubscription =
        _chatService.errorStreamController.stream.listen((event) {
      add(JoinEvent.joinFailure);
    });
    _joinResponseStreamSubscription =
        _chatService.joinResponseController.stream.listen((event) {
      if (event.confirmation) {
        add(JoinEvent.joinSuccess);
      }
    });
  }

  final ChatService _chatService;

  @override
  Stream<JoinState> mapEventToState(JoinEvent event) async* {
    switch (event) {
      case JoinEvent.joinStarted:
        yield JoinState.inProgress();
        await _chatService.join();
        break;
      case JoinEvent.joinSuccess:
        yield JoinState.success();
        break;
      case JoinEvent.joinFailure:
        yield JoinState.failure("Connection error");
        await Future.delayed(Duration(seconds: 2));
        yield JoinState.inProgress();
        await _chatService.join();
        break;
      default:
        yield JoinState.initial();
    }
  }

  @override
  Future<void> close() {
    _errorStreamSubscription.cancel();
    _joinResponseStreamSubscription.cancel();
    return super.close();
  }
}
