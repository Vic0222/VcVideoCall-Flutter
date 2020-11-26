//Use class instead of enum to pass data to events

import 'package:equatable/equatable.dart';

abstract class SendMessageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendMessageStarted extends SendMessageEvent {
  SendMessageStarted(this.roomId, this.message);

  final String roomId;
  final String message;

  @override
  List<Object> get props => [roomId, message];
}
