import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/getrooms/get_rooms_event.dart';
import 'package:vc_video_call/blocs/getrooms/get_rooms_state.dart';
import 'package:vc_video_call/services/chat_service.dart';

class GetRoomsBloc extends Bloc<GetRoomsEvent, GetRoomsState> {
  GetRoomsBloc(this._chatService) : super(GetRoomsState.initial()) {
    add(GetRoomsEvent.GetRoomsStarted);
  }
  final ChatService _chatService;

  @override
  Stream<GetRoomsState> mapEventToState(GetRoomsEvent event) async* {
    switch (event) {
      case GetRoomsEvent.GetRoomsStarted:
        yield GetRoomsState.inProgress();
        try {
          var roomList = await _chatService.getRooms();
          yield GetRoomsState.success(roomList);
        } catch (e) {
          yield GetRoomsState.failure("Connection error");
        }
        break;
      default:
        yield GetRoomsState.initial();
    }
  }
}
