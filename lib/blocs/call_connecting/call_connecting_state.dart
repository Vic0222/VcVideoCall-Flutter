import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

enum CallConnectingStatus { initial, inProgress, success, failure }

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

  CallConnectingState.initial() : this._();

  CallConnectingState.inProgress(RTCVideoRenderer localRenderer)
      : this._(
          status: CallConnectingStatus.inProgress,
          localRenderer: localRenderer,
        );

  CallConnectingState.success(String userId, RTCVideoRenderer localRenderer,
      RTCVideoRenderer remoteRenderer)
      : this._(
          status: CallConnectingStatus.success,
          localRenderer: localRenderer,
          remoteRenderer: remoteRenderer,
        );

  CallConnectingState.failure(String errorMessage)
      : this._(
            status: CallConnectingStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [
        status,
        errorMessage,
        localRenderer,
        remoteRenderer,
      ];
}
