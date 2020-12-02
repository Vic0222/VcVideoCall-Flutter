import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

enum CallConnectingStatus { initial, inProgress, success, failure, close }

class CallConnectingState extends Equatable {
  final CallConnectingStatus status;
  final String errorMessage;
  final String roomId;
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;

  const CallConnectingState._({
    this.status = CallConnectingStatus.initial,
    this.localRenderer,
    this.remoteRenderer,
    this.roomId,
    this.errorMessage = "",
  });

  CallConnectingState.initial(RTCVideoRenderer localRenderer)
      : this._(localRenderer: localRenderer);

  CallConnectingState.inProgress(String roomId, RTCVideoRenderer localRenderer)
      : this._(
          status: CallConnectingStatus.inProgress,
          localRenderer: localRenderer,
          roomId: roomId,
        );

  CallConnectingState.success(String roomId, RTCVideoRenderer localRenderer,
      RTCVideoRenderer remoteRenderer)
      : this._(
          status: CallConnectingStatus.success,
          localRenderer: localRenderer,
          remoteRenderer: remoteRenderer,
          roomId: roomId,
        );

  CallConnectingState.failure(
    String errorMessage,
    RTCVideoRenderer localRenderer,
    RTCVideoRenderer remoteRenderer,
  ) : this._(
          status: CallConnectingStatus.failure,
          errorMessage: errorMessage,
          localRenderer: localRenderer,
          remoteRenderer: remoteRenderer,
        );

  CallConnectingState.close(
    RTCVideoRenderer localRenderer,
    RTCVideoRenderer remoteRenderer,
  ) : this._(
          status: CallConnectingStatus.close,
          errorMessage: "Connection was closed",
          localRenderer: localRenderer,
          remoteRenderer: remoteRenderer,
        );

  @override
  List<Object> get props => [
        status,
        errorMessage,
        localRenderer,
        remoteRenderer,
        roomId,
      ];
}
