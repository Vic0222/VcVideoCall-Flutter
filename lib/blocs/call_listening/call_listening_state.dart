import 'package:equatable/equatable.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

enum CallListeningStatus {
  initial,
  listeningInProgress,
  ringingInProgress,
  callInProgress,
  failure
}

class CallListeningState extends Equatable {
  final CallListeningStatus status;
  final CallOfferNotification callOfferNotification;
  final String errorMessage;
  final bool withVideo;

  const CallListeningState._({
    this.status = CallListeningStatus.initial,
    this.callOfferNotification,
    this.errorMessage = "",
    this.withVideo = true,
  });

  CallListeningState.initial() : this._();

  CallListeningState.listeningInProgress()
      : this._(status: CallListeningStatus.listeningInProgress);

  CallListeningState.ringingInProgress(
      CallOfferNotification callOfferNotification)
      : this._(
            status: CallListeningStatus.ringingInProgress,
            callOfferNotification: callOfferNotification);

  CallListeningState.callInProgress(
      CallOfferNotification callOfferNotification, bool withVideo)
      : this._(
          status: CallListeningStatus.callInProgress,
          callOfferNotification: callOfferNotification,
          withVideo: withVideo,
        );

  CallListeningState.failure(String errorMessage)
      : this._(status: CallListeningStatus.failure, errorMessage: errorMessage);

  @override
  List<Object> get props => [status, errorMessage];
}
