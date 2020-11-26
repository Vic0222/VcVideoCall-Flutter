import 'package:flutter/material.dart';
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
        child: Container(
          constraints: BoxConstraints(
            minHeight: 34,
          ),
          padding: EdgeInsets.all(8),
          child: Text(
            message.messageBody,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
