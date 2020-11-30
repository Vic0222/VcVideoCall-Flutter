//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';

abstract class CallInitiateEvent extends Equatable {
  CallInitiateEvent(this.roomId);

  final String roomId;
  @override
  List<Object> get props => [roomId];
}

class CallInitiateStarted extends CallInitiateEvent {
  CallInitiateStarted(String roomId) : super(roomId);
}

class CallInitiateSucceeded extends CallInitiateEvent {
  CallInitiateSucceeded(String roomId) : super(roomId);
}

class CallInitiateCancelled extends CallInitiateEvent {
  CallInitiateCancelled(String roomId) : super(roomId);
}

class CallInitiateFailed extends CallInitiateEvent {
  CallInitiateFailed(String roomId, this.errorMessage) : super(roomId);

  final String errorMessage;
}
