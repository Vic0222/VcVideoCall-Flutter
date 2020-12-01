//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

abstract class CallListeningEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CallListningStarted extends CallListeningEvent {}

class CallListningCallDeclined extends CallListeningEvent {
  CallListningCallDeclined(this.callOfferNotification);
  final CallOfferNotification callOfferNotification;
  @override
  List<Object> get props => [callOfferNotification];
}

class CallListningCallAccepted extends CallListeningEvent {
  CallListningCallAccepted(this.callOfferNotification, {this.withVideo = true});
  final bool withVideo;
  final CallOfferNotification callOfferNotification;
  @override
  List<Object> get props => [callOfferNotification];
}

class CallListningCallReceived extends CallListeningEvent {
  CallListningCallReceived(this.callOfferNotification);
  final CallOfferNotification callOfferNotification;
  @override
  List<Object> get props => [callOfferNotification];
}
