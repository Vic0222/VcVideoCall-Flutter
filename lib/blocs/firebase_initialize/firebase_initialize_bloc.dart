import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/firebase_initialize/firebase_initialize_event.dart';
import 'package:vc_video_call/blocs/firebase_initialize/firebase_initialize_state.dart';
import 'package:vc_video_call/services/authentication_service.dart';

class FirebaseInitializeBloc
    extends Bloc<FirebaseInitializeEvent, FirebaseInitializeState> {
  FirebaseInitializeBloc(this._loginService)
      : super(FirebaseInitializeState.initial()) {
    add(FirebaseInitializeEvent.firebaseInitializeStarted);
  }

  final AuthenticationService _loginService;

  @override
  Stream<FirebaseInitializeState> mapEventToState(
      FirebaseInitializeEvent event) async* {
    switch (event) {
      case FirebaseInitializeEvent.firebaseInitializeStarted:
        yield FirebaseInitializeState.inProgress();
        try {
          await _loginService.initialize();
          yield FirebaseInitializeState.success();
        } catch (e) {
          yield FirebaseInitializeState.failure("login initialization error");
          log(e.toString());
        }
        break;
      default:
        yield FirebaseInitializeState.initial();
    }
  }
}
