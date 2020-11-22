import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/login/login_event.dart';
import 'package:vc_video_call/blocs/login/login_state.dart';
import 'package:vc_video_call/services/login_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._loginService) : super(LoginState.initial());

  final LoginService _loginService;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    switch (event) {
      case LoginEvent.loginStarted:
        yield LoginState.inProgress();
        bool success = await _loginService.signInWithGoogle();
        yield success ? LoginState.success() : LoginState.failure();
        break;
      default:
        yield LoginState.initial();
    }
  }
}
