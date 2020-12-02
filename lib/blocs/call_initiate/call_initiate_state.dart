import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

enum CallInitiateStatus { initial, inProgress, success, failure }

class CallInitiateState extends Equatable {
  final CallInitiateStatus status;
  final String errorMessage;
  final String roomId;
  final RTCVideoRenderer localRenderer;
  final bool withVideo;

  const CallInitiateState._({
    this.status = CallInitiateStatus.initial,
    this.errorMessage = "",
    this.roomId = "",
    this.localRenderer,
    this.withVideo = true,
  });

  CallInitiateState.initial() : this._();

  CallInitiateState.inProgress(
      String roomId, RTCVideoRenderer localRenderer, bool withVideo)
      : this._(
          status: CallInitiateStatus.inProgress,
          roomId: roomId,
          localRenderer: localRenderer,
        );

  CallInitiateState.success(String roomId, bool withVideo)
      : this._(
          status: CallInitiateStatus.success,
          roomId: roomId,
        );

  CallInitiateState.failure(String errorMessage)
      : this._(status: CallInitiateStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [
        status,
        errorMessage,
        roomId,
        localRenderer,
        withVideo,
      ];
}
