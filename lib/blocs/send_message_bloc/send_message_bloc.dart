import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/send_message_bloc/send_message_event.dart';
import 'package:vc_video_call/blocs/send_message_bloc/send_message_state.dart';
import 'package:vc_video_call/services/chat_service.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  SendMessageBloc(this._chatService) : super(SendMessageState.initial());
  final ChatService _chatService;

  @override
  Stream<SendMessageState> mapEventToState(SendMessageEvent event) async* {
    if (event is SendMessageStarted) {
      try {
        yield SendMessageState.inProgress();
        _onStartSendMessage(event);
        yield SendMessageState.success();
      } catch (e) {
        yield SendMessageState.failure(e.toString());
      }
    } else {
      yield SendMessageState.initial();
    }
  }

  void startSendMessage(String roomId, String message) {
    var sendMessageEvent = SendMessageStarted(roomId, message);
    add(sendMessageEvent);
  }

  void _onStartSendMessage(SendMessageStarted event) {
    _chatService.sendMessage(event.roomId, event.message);
  }
}
