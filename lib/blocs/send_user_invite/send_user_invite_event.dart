//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

abstract class SendUserInviteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendUserInviteStarted extends SendUserInviteEvent {
  SendUserInviteStarted(this.userid);

  final String userid;

  @override
  List<Object> get props => [userid];
}
