import 'package:flutter/material.dart';
import 'package:vc_video_call/components/message_container.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

class ReceiverMessageCard extends StatelessWidget {
  const ReceiverMessageCard(
    this.message, {
    Key key,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(right: 100),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: MessageContainer(
          message: message.messageBody,
          textStyle: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
