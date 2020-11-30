import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

enum CallInitiateStatus { initial, inProgress, success, failure }

class CallInitiateState extends Equatable {
  final CallInitiateStatus status;
  final String errorMessage;
  final String roomId;
  final RTCVideoRenderer localRenderer;

  const CallInitiateState._({
    this.status = CallInitiateStatus.initial,
    this.errorMessage = "",
    this.roomId = "",
    this.localRenderer,
  });

  CallInitiateState.initial() : this._();

  CallInitiateState.inProgress(String roomId, RTCVideoRenderer localRenderer)
      : this._(
          status: CallInitiateStatus.inProgress,
          roomId: roomId,
          localRenderer: localRenderer,
        );

  CallInitiateState.success(String roomId)
      : this._(
          status: CallInitiateStatus.success,
          roomId: roomId,
        );

  CallInitiateState.failure(String errorMessage)
      : this._(status: CallInitiateStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, errorMessage];
}
