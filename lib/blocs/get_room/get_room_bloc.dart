import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/services/chat_service.dart';

import 'get_room_event.dart';
import 'get_room_state.dart';

class GetRoomBloc extends Bloc<GetRoomEvent, GetRoomState> {
  GetRoomBloc(this._chatService) : super(GetRoomState.initial());
  final ChatService _chatService;

  @override
  Stream<GetRoomState> mapEventToState(GetRoomEvent event) async* {
    if (event is GetRoomStarted) {
      try {
        yield GetRoomState.inProgress();
        var room = await _chatService.getRoom(event.userId, event.roomId);
        yield GetRoomState.success(room);
      } catch (e) {
        yield GetRoomState.failure(e.toString());
      }
    }
  }

  void startGetRoom(String userId, String roomId) {
    add(GetRoomStarted(userId: userId, roomId: roomId));
  }
}
