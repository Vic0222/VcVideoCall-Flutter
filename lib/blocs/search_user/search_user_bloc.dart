import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/grpc/generated/chat.pbgrpc.dart';
import 'package:vc_video_call/services/chat_service.dart';

import 'search_user_event.dart';
import 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchUserBloc(this._chatService) : super(SearchUserState.initial());
  final ChatService _chatService;

  @override
  Stream<SearchUserState> mapEventToState(SearchUserEvent event) async* {
    if (event is SearchUserStarted) {
      try {
        yield SearchUserState.inProgress();
        try {
          var users = await _onStartSearchUser(event);
          yield SearchUserState.success(users);
        } catch (e) {
          SearchUserState.failure(e.toString());
        }
      } catch (e) {
        yield SearchUserState.failure(e.toString());
      }
    } else {
      yield SearchUserState.initial();
    }
  }

  void startSearchUser(String keyword) {
    var searchUserEvent = SearchUserStarted(keyword);
    add(searchUserEvent);
  }

  Future<List<User>> _onStartSearchUser(SearchUserStarted event) async {
    return await _chatService.searchUser(event.keyword);
  }
}
