import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/get_messages/get_messages_event.dart';
import 'package:vc_video_call/blocs/get_messages/get_messages_state.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';
import 'package:vc_video_call/services/authentication_service.dart';
import 'package:vc_video_call/services/chat_service.dart';

class GetMessagesBloc extends Bloc<GetMessagesEvent, GetMessagesState> {
  final ChatService _chatService;
  final AuthenticationService _authenticationService;
  StreamSubscription<JoinResponse> _joinSubscription;

  GetMessagesBloc(this._chatService, this._authenticationService)
      : super(GetMessagesState.initial()) {
    _joinSubscription =
        _chatService.joinResponseController.stream.listen((response) {
      add(GetMessagesStarted(response.messageNotification.roomId, Int64.ONE));
    });
  }

  @override
  Stream<GetMessagesState> mapEventToState(GetMessagesEvent event) async* {
    if (event is GetMessagesStarted) {
      try {
        yield GetMessagesState.inProgress();
        var response = await _onStartGetMessages(event);
        var userId = _authenticationService.getUserId();
        yield GetMessagesState.success(response, userId);
      } catch (e) {
        yield GetMessagesState.failure(e.toString());
      }
    } else {
      yield GetMessagesState.initial();
    }
  }

  void startGetMessages(String roomId, {Int64 timestamp = Int64.ZERO}) {
    add(GetMessagesStarted(roomId, timestamp));
  }

  Future<GetMessagesResponse> _onStartGetMessages(
      GetMessagesStarted event) async {
    var response =
        await _chatService.getMessages(event.roomId, event.timestamp);
    return response;
  }

  @override
  Future close() async {
    super.close();
    await _joinSubscription?.cancel();
  }
}
