import 'package:equatable/equatable.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

enum SendInviteAcceptStatus { initial, inProgress, success, failure }

class SendInviteAcceptState extends Equatable {
  final SendInviteAcceptStatus status;
  final String errorMessage;
  final String roomId;
  final Room room;

  const SendInviteAcceptState._({
    this.status = SendInviteAcceptStatus.initial,
    this.errorMessage = "",
    this.roomId,
    this.room,
  });

  SendInviteAcceptState.initial() : this._();

  SendInviteAcceptState.inProgress(String roomId)
      : this._(status: SendInviteAcceptStatus.inProgress, roomId: roomId);

  SendInviteAcceptState.success(String roomId, Room room)
      : this._(
          status: SendInviteAcceptStatus.success,
          roomId: roomId,
          room: room,
        );

  SendInviteAcceptState.failure(String roomId, String errorMessage)
      : this._(
          status: SendInviteAcceptStatus.failure,
          errorMessage: errorMessage,
          roomId: roomId,
        );

  @override
  List<Object> get props => [status, errorMessage, roomId, room];
}
