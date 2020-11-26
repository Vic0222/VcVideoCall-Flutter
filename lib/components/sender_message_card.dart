import 'package:flutter/material.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard(
    this.message, {
    Key key,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(left: 100),
      child: Card(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 34,
          ),
          padding: EdgeInsets.all(8),
          child: Text(
            message.messageBody,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
