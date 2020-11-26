import 'package:equatable/equatable.dart';

enum SendMessageStatus { initial, inProgress, success, failure }

class SendMessageState extends Equatable {
  final SendMessageStatus status;
  final String errorMessage;

  const SendMessageState._({
    this.status = SendMessageStatus.initial,
    this.errorMessage = "",
  });

  SendMessageState.initial() : this._();

  SendMessageState.inProgress() : this._(status: SendMessageStatus.inProgress);

  SendMessageState.success()
      : this._(
          status: SendMessageStatus.success,
        );

  SendMessageState.failure(String errorMessage)
      : this._(status: SendMessageStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, errorMessage];
}
