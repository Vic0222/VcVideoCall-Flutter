import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/profilepic/profilepic_event.dart';
import 'package:vc_video_call/blocs/profilepic/profilepic_state.dart';
import 'package:vc_video_call/services/authentication_service.dart';

class ProfilePicBloc extends Bloc<ProfilePicEvent, ProfilePicState> {
  ProfilePicBloc(this._authenticationService)
      : super(ProfilePicState.initial());

  final AuthenticationService _authenticationService;

  @override
  Stream<ProfilePicState> mapEventToState(ProfilePicEvent event) async* {
    switch (event) {
      case ProfilePicEvent.GetProfilePicStarted:
        yield ProfilePicState.inProgress();
        try {
          String photoURL = _authenticationService.getUserPhotoURL();
          yield ProfilePicState.success(photoURL);
        } catch (e) {
          yield ProfilePicState.failure("Connection error");
        }
        break;
      default:
        yield ProfilePicState.initial();
    }
  }
}
