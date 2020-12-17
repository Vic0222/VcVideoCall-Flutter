import 'package:equatable/equatable.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

enum SendUserInviteStatus { initial, inProgress, success, failure }

class SendUserInviteState extends Equatable {
  final SendUserInviteStatus status;
  final String errorMessage;
  final String userId;
  final Room room;

  const SendUserInviteState._({
    this.status = SendUserInviteStatus.initial,
    this.errorMessage = "",
    this.userId,
    this.room,
  });

  SendUserInviteState.initial() : this._();

  SendUserInviteState.inProgress(String userId)
      : this._(status: SendUserInviteStatus.inProgress, userId: userId);

  SendUserInviteState.success(String userId, Room room)
      : this._(
          status: SendUserInviteStatus.success,
          userId: userId,
          room: room,
        );

  SendUserInviteState.failure(String userId, String errorMessage)
      : this._(
          status: SendUserInviteStatus.failure,
          errorMessage: errorMessage,
          userId: userId,
        );

  @override
  List<Object> get props => [status, errorMessage, userId, room];
}
