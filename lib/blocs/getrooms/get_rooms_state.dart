import 'package:equatable/equatable.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

enum GetRoomsStatus { initial, inProgress, success, failure }

class GetRoomsState extends Equatable {
  final GetRoomsStatus status;
  final String errorMessage;
  final RoomListReply roomListReply;

  const GetRoomsState._({
    this.status = GetRoomsStatus.initial,
    this.errorMessage = "",
    this.roomListReply,
  });

  GetRoomsState.initial() : this._();

  GetRoomsState.inProgress() : this._(status: GetRoomsStatus.inProgress);

  GetRoomsState.success(RoomListReply roomListReply)
      : this._(status: GetRoomsStatus.success, roomListReply: roomListReply);

  GetRoomsState.failure(String errorMessage)
      : this._(status: GetRoomsStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, errorMessage];
}
