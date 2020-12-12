import 'package:equatable/equatable.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

enum GetRoomStatus { initial, inProgress, success, failure }

class GetRoomState extends Equatable {
  final GetRoomStatus status;
  final String errorMessage;
  final Room room;

  const GetRoomState._({
    this.status = GetRoomStatus.initial,
    this.errorMessage = "",
    this.room,
  });

  GetRoomState.initial() : this._();

  GetRoomState.inProgress() : this._(status: GetRoomStatus.inProgress);

  GetRoomState.success(Room room)
      : this._(status: GetRoomStatus.success, room: room);

  GetRoomState.failure(String errorMessage)
      : this._(status: GetRoomStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, room, errorMessage];
}
