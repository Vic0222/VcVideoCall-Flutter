import 'package:flutter/material.dart';
import 'package:vc_video_call/components/receiver_message_card.dart';
import 'package:vc_video_call/components/sender_message_card.dart';
import 'package:vc_video_call/custom_classes/custom_color_scheme.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _chatTextEditingController;
  @override
  void initState() {
    super.initState();
    _chatTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        title: Row(
          children: [
            Image.asset("assets/images/profile-pic-placeholder.png"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Juan Dela Cruz",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Online",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryDeEmphasize,
                        ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              reverse: true,
              itemBuilder: (context, i) {
                Widget widget;
                if (i % 2 == 0) {
                  widget = SenderMessageCard();
                } else {
                  widget = ReceiverMessageCard();
                }
                return widget;
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 56,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      controller: _chatTextEditingController,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
