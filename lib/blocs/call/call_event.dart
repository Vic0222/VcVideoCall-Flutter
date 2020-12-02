//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

abstract class CallEvent extends Equatable {
  CallEvent({this.roomId, this.peerConnection, this.withVideo});

  final String roomId;
  final RTCPeerConnection peerConnection;
  final bool withVideo;
  @override
  List<Object> get props => [roomId, peerConnection, withVideo];
}

class CallAudioToggledEvent extends CallEvent {}

class CallVideoToggledEvent extends CallEvent {}

class CallStartedEvent extends CallEvent {
  CallStartedEvent(String roomId, {bool withVideo = true})
      : super(roomId: roomId, withVideo: withVideo);
}

class CallEndedEvent extends CallEvent {
  CallEndedEvent(String roomId, RTCPeerConnection peerConnection)
      : super(roomId: roomId, peerConnection: peerConnection);
}

class CallEndedFomServerEvent extends CallEvent {
  CallEndedFomServerEvent(String roomId, RTCPeerConnection peerConnection)
      : super(roomId: roomId, peerConnection: peerConnection);
}
