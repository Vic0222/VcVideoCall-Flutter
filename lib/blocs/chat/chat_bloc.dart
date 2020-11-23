import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/chat/chat_event.dart';
import 'package:vc_video_call/blocs/chat/chat_state.dart';
import 'package:vc_video_call/services/chat_service.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._chatService) : super(ChatState.initial()) {
    add(ChatEvent.chatStartJoin);
  }

  final ChatService _chatService;

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    switch (event) {
      case ChatEvent.chatStartJoin:
        yield ChatState.inProgress();
        try {
          await _chatService.tryJoin();
          yield ChatState.success();
        } catch (e) {
          yield ChatState.failure("Connection error");
        }
        break;
      default:
        yield ChatState.initial();
    }
  }
}
