import 'package:equatable/equatable.dart';

enum JoinStatus { initial, inProgress, success, failure }

class ChatState extends Equatable {
  final JoinStatus status;
  final String errorMessage;

  const ChatState._({
    this.status = JoinStatus.initial,
    this.errorMessage = "",
  });

  ChatState.initial() : this._();

  ChatState.inProgress() : this._(status: JoinStatus.inProgress);

  ChatState.success() : this._(status: JoinStatus.success);

  ChatState.failure(String errorMessage)
      : this._(status: JoinStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, errorMessage];
}
