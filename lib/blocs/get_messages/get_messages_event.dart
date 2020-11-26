//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';
import 'package:fixnum/fixnum.dart';

abstract class GetMessagesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMessagesStarted extends GetMessagesEvent {
  GetMessagesStarted(this.roomId, this.timestamp);

  final String roomId;
  final Int64 timestamp;

  @override
  List<Object> get props => [roomId];
}
