//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';

abstract class GetMessagesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMessagesStarted extends GetMessagesEvent {
  GetMessagesStarted(this.roomId);

  final String roomId;

  @override
  List<Object> get props => [roomId];
}
