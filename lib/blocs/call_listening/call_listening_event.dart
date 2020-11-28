//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

abstract class CallListeningEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CallListningStarted extends CallListeningEvent {}

class CallListningCallDeclined extends CallListeningEvent {}

class CallListningCallReceived extends CallListeningEvent {
  CallListningCallReceived(this.callOfferNotification);
  final CallOfferNotification callOfferNotification;
  @override
  List<Object> get props => [callOfferNotification];
}
