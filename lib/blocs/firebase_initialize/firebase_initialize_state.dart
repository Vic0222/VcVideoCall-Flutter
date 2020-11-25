import 'package:equatable/equatable.dart';

enum FirebaseInitializeStatus { initial, inProgress, success, failure }

class FirebaseInitializeState extends Equatable {
  final FirebaseInitializeStatus status;
  final String errorMessage;

  const FirebaseInitializeState._({
    this.status = FirebaseInitializeStatus.initial,
    this.errorMessage = "",
  });

  FirebaseInitializeState.initial() : this._();

  FirebaseInitializeState.inProgress()
      : this._(status: FirebaseInitializeStatus.inProgress);

  FirebaseInitializeState.success()
      : this._(status: FirebaseInitializeStatus.success);

  FirebaseInitializeState.failure(String errorMessage)
      : this._(
          status: FirebaseInitializeStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object> get props => [status, errorMessage];
}
