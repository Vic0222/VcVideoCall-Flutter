import 'package:equatable/equatable.dart';
import 'package:vc_video_call/grpc/generated/chat.pbgrpc.dart';

enum SearchUserStatus { initial, inProgress, success, failure }

class SearchUserState extends Equatable {
  final SearchUserStatus status;
  final String errorMessage;
  final List<User> users;

  const SearchUserState._({
    this.status = SearchUserStatus.initial,
    this.users,
    this.errorMessage = "",
  });

  SearchUserState.initial() : this._();

  SearchUserState.inProgress() : this._(status: SearchUserStatus.inProgress);

  SearchUserState.success(List<User> users)
      : this._(
          status: SearchUserStatus.success,
          users: users,
        );

  SearchUserState.failure(String errorMessage)
      : this._(status: SearchUserStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, users, errorMessage];
}
