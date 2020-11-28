import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

enum CallInitiateStatus { initial, inProgress, success, failure }

class CallInitiateState extends Equatable {
  final CallInitiateStatus status;
  final String errorMessage;
  final RTCVideoRenderer localRenderer;

  const CallInitiateState._({
    this.status = CallInitiateStatus.initial,
    this.errorMessage = "",
    this.localRenderer,
  });

  CallInitiateState.initial() : this._();

  CallInitiateState.inProgress(RTCVideoRenderer localRenderer)
      : this._(
          status: CallInitiateStatus.inProgress,
          localRenderer: localRenderer,
        );

  CallInitiateState.success(String userId)
      : this._(
          status: CallInitiateStatus.success,
        );

  CallInitiateState.failure(String errorMessage)
      : this._(status: CallInitiateStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, errorMessage];
}
