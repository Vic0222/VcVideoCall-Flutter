//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';

abstract class SendInviteAcceptEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendInviteAcceptStarted extends SendInviteAcceptEvent {
  SendInviteAcceptStarted(this.roomId);

  final String roomId;

  @override
  List<Object> get props => [roomId];
}
