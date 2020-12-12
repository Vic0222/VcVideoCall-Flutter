import 'package:equatable/equatable.dart';

abstract class GetRoomEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRoomStarted extends GetRoomEvent {
  GetRoomStarted({this.userId, this.roomId});

  final String userId;
  final String roomId;

  @override
  List<Object> get props => [userId, roomId];
}
