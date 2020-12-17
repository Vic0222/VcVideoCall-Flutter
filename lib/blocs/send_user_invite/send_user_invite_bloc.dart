import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/send_user_invite/send_user_invite_event.dart';
import 'package:vc_video_call/blocs/send_user_invite/send_user_invite_state.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';
import 'package:vc_video_call/services/chat_service.dart';

class SendUserInviteBloc
    extends Bloc<SendUserInviteEvent, SendUserInviteState> {
  SendUserInviteBloc(this._chatService) : super(SendUserInviteState.initial());
  final ChatService _chatService;

  @override
  Stream<SendUserInviteState> mapEventToState(
      SendUserInviteEvent event) async* {
    if (event is SendUserInviteStarted) {
      try {
        yield SendUserInviteState.inProgress(event.userid);
        var room = await _onStartSendUserInvite(event);
        yield SendUserInviteState.success(event.userid, room);
      } catch (e) {
        yield SendUserInviteState.failure(event.userid, e.toString());
      }
    } else {
      yield SendUserInviteState.initial();
    }
  }

  void startSendUserInvite(String userId) {
    var sendUserInviteEvent = SendUserInviteStarted(userId);
    add(sendUserInviteEvent);
  }

  Future<Room> _onStartSendUserInvite(SendUserInviteStarted event) async {
    return await _chatService.sendUserInvite(event.userid);
  }
}
