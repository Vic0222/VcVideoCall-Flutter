import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/chat/chat_event.dart';
import 'package:vc_video_call/blocs/chat/chat_state.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';
import 'package:vc_video_call/services/chat_service.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  StreamSubscription<String> _errorStreamSubscription;
  StreamSubscription<JoinReply> _joinReplyStreamSubscription;

  ChatBloc(this._chatService) : super(ChatState.initial()) {
    add(ChatEvent.chatJoinStarted);
    _errorStreamSubscription =
        _chatService.errorStreamController.stream.listen((event) {
      add(ChatEvent.chatDisconnected);
    });
    _joinReplyStreamSubscription =
        _chatService.joinReplyController.stream.listen((event) {
      if (event.confirmation) {
        add(ChatEvent.chatConnected);
      }
    });
  }

  final ChatService _chatService;

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    switch (event) {
      case ChatEvent.chatJoinStarted:
        yield ChatState.inProgress();
        await _chatService.join();
        break;
      case ChatEvent.chatConnected:
        yield ChatState.success();
        break;
      case ChatEvent.chatDisconnected:
        yield ChatState.failure("Connection error");
        await Future.delayed(Duration(seconds: 2));
        yield ChatState.inProgress();
        await _chatService.join();
        break;
      default:
        yield ChatState.initial();
    }
  }

  @override
  Future<void> close() {
    _errorStreamSubscription.cancel();
    _joinReplyStreamSubscription.cancel();
    return super.close();
  }
}
