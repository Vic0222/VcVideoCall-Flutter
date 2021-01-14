import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/send_invite_accept/send_user_invite_event.dart';
import 'package:vc_video_call/blocs/send_invite_accept/send_user_invite_state.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';
import 'package:vc_video_call/services/chat_service.dart';

class SendInviteAcceptBloc
    extends Bloc<SendInviteAcceptEvent, SendInviteAcceptState> {
  SendInviteAcceptBloc(this._chatService)
      : super(SendInviteAcceptState.initial());
  final ChatService _chatService;

  @override
  Stream<SendInviteAcceptState> mapEventToState(
      SendInviteAcceptEvent event) async* {
    if (event is SendInviteAcceptStarted) {
      try {
        yield SendInviteAcceptState.inProgress(event.roomId);
        var room = await _onStartSendInviteAccept(event);
        yield SendInviteAcceptState.success(event.roomId, room);
      } catch (e) {
        yield SendInviteAcceptState.failure(event.roomId, e.toString());
      }
    } else {
      yield SendInviteAcceptState.initial();
    }
  }

  void startSendInviteAccept(String userId) {
    var sendInviteAcceptEvent = SendInviteAcceptStarted(userId);
    add(sendInviteAcceptEvent);
  }

  Future<Room> _onStartSendInviteAccept(SendInviteAcceptStarted event) async {
    return await _chatService.sendUserAccept(event.roomId);
  }
}
