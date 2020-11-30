//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

abstract class CallEvent extends Equatable {
  CallEvent({this.roomId, this.peerConnection});

  final String roomId;
  final RTCPeerConnection peerConnection;
  @override
  List<Object> get props => [roomId, peerConnection];
}

class CallAudioToggledEvent extends CallEvent {}

class CallVideoToggledEvent extends CallEvent {}

class CallStartedEvent extends CallEvent {
  CallStartedEvent(
    String roomId,
  ) : super(roomId: roomId);
}

class CallEndedEvent extends CallEvent {
  CallEndedEvent(String roomId, RTCPeerConnection peerConnection)
      : super(roomId: roomId, peerConnection: peerConnection);
}
