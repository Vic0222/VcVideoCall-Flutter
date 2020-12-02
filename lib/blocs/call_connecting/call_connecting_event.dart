//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

abstract class CallConnectingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CallConnectingStartedEvent extends CallConnectingEvent {
  CallConnectingStartedEvent(this.roomId);

  final String roomId;
  @override
  List<Object> get props => [roomId];
}

class CallConnectingConnectionStateChanged extends CallConnectingEvent {
  CallConnectingConnectionStateChanged(this.roomId, this.connectionState);

  final String roomId;
  final RTCPeerConnectionState connectionState;
  @override
  List<Object> get props => [roomId];
}
