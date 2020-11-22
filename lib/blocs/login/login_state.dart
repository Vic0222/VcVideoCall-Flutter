import 'package:equatable/equatable.dart';

enum LoginStatus { initial, inProgress, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String errorMessage;

  const LoginState._({
    this.status = LoginStatus.initial,
    this.errorMessage = "",
  });

  LoginState.initial() : this._();

  LoginState.inProgress() : this._(status: LoginStatus.inProgress);

  LoginState.success() : this._(status: LoginStatus.success);

  LoginState.failure() : this._(status: LoginStatus.failure);

  @override
  List<Object> get props => [status, errorMessage];
}
