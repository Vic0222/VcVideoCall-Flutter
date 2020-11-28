//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';

abstract class CallInitiateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CallInitiateStarted extends CallInitiateEvent {
  CallInitiateStarted(this.roomId);

  final String roomId;
  @override
  List<Object> get props => [roomId];
}

class CallInitiateCancelled extends CallInitiateEvent {
  CallInitiateCancelled(this.roomId);

  final String roomId;
  @override
  List<Object> get props => [roomId];
}
