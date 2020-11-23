import 'package:equatable/equatable.dart';

enum AuthenticationStatus { initial, inProgress, success, failure }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final String errorMessage;

  const AuthenticationState._({
    this.status = AuthenticationStatus.initial,
    this.errorMessage = "",
  });

  AuthenticationState.initial() : this._();

  AuthenticationState.inProgress()
      : this._(status: AuthenticationStatus.inProgress);

  AuthenticationState.success() : this._(status: AuthenticationStatus.success);

  AuthenticationState.failure() : this._(status: AuthenticationStatus.failure);

  @override
  List<Object> get props => [status, errorMessage];
}
