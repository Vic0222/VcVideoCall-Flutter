import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

enum CallStatus { initial, inProgress, done, failure }

class CallState extends Equatable {
  final CallStatus status;
  final String errorMessage;
  final String roomId;
  final RTCPeerConnection peerConnection;
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;
  final bool audioEnabled;
  final bool videoEnabled;

  const CallState._({
    this.status = CallStatus.initial,
    this.roomId,
    this.peerConnection,
    this.localRenderer,
    this.remoteRenderer,
    this.audioEnabled,
    this.videoEnabled,
    this.errorMessage = "",
  });

  CallState.initial() : this._();

  CallState.inProgress(
    String roomId,
    RTCPeerConnection peerConnection,
    RTCVideoRenderer localRenderer,
    RTCVideoRenderer remoteRenderer, {
    bool audioEnabled = true,
    bool videoEnabled = true,
  }) : this._(
          status: CallStatus.inProgress,
          roomId: roomId,
          peerConnection: peerConnection,
          localRenderer: localRenderer,
          remoteRenderer: remoteRenderer,
          videoEnabled: audioEnabled,
          audioEnabled: videoEnabled,
        );

  CallState.done(String roomId, RTCPeerConnection peerConnection)
      : this._(
          status: CallStatus.done,
          roomId: roomId,
          peerConnection: peerConnection,
        );

  CallState.failure(String errorMessage)
      : this._(status: CallStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, errorMessage, peerConnection, roomId];
}
