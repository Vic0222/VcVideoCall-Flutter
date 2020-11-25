import 'package:equatable/equatable.dart';

enum JoinStatus { initial, inProgress, success, failure }

class JoinState extends Equatable {
  final JoinStatus status;
  final String errorMessage;

  const JoinState._({
    this.status = JoinStatus.initial,
    this.errorMessage = "",
  });

  JoinState.initial() : this._();

  JoinState.inProgress() : this._(status: JoinStatus.inProgress);

  JoinState.success() : this._(status: JoinStatus.success);

  JoinState.failure(String errorMessage)
      : this._(status: JoinStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, errorMessage];
}
