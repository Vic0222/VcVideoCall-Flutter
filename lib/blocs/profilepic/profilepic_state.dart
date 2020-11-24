import 'package:equatable/equatable.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

enum GetProfilePicStatus { initial, inProgress, success, failure }

class ProfilePicState extends Equatable {
  final GetProfilePicStatus status;
  final String errorMessage;
  final String photoURL;

  const ProfilePicState._(
      {this.status = GetProfilePicStatus.initial,
      this.errorMessage = "",
      this.photoURL = ""});

  ProfilePicState.initial() : this._();

  ProfilePicState.inProgress() : this._(status: GetProfilePicStatus.inProgress);

  ProfilePicState.success(String photoURL)
      : this._(status: GetProfilePicStatus.success, photoURL: photoURL);

  ProfilePicState.failure(String errorMessage)
      : this._(status: GetProfilePicStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, errorMessage];
}
