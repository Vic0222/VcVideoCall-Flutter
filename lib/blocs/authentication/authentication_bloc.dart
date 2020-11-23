import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/authentication/authentication_event.dart';
import 'package:vc_video_call/blocs/authentication/authentication_state.dart';
import 'package:vc_video_call/services/authentication_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._loginService) : super(AuthenticationState.initial());

  final AuthenticationService _loginService;

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    switch (event) {
      case AuthenticationEvent.authenticationStarted:
        yield AuthenticationState.inProgress();
        bool success = await _loginService.signInWithGoogle();
        yield success
            ? AuthenticationState.success()
            : AuthenticationState.failure();
        break;
      default:
        yield AuthenticationState.initial();
    }
  }
}
