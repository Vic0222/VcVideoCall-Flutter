//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';

abstract class CallInitiateEvent extends Equatable {
  CallInitiateEvent(this.roomId, {this.withVideo = true});

  final String roomId;
  final bool withVideo;
  @override
  List<Object> get props => [roomId, withVideo];
}

class CallInitiateStarted extends CallInitiateEvent {
  CallInitiateStarted(String roomId, bool withVideo)
      : super(roomId, withVideo: withVideo);
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
