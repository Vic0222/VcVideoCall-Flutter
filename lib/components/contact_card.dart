import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

class ContactCard extends StatelessWidget {
  ContactCard(this.room);

  final RoomReply room;

  @override
  Widget build(BuildContext context) {
    int miliseconds = room.lastMessageDatetime.toInt() * 1000;
    var dateSent = DateTime.fromMillisecondsSinceEpoch(miliseconds);
    var dateFormatted = DateFormat("dd/MM/yyyy").format(dateSent);
    return InkWell(
      onTap: () {
        openChatPage(context);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                dateFormatted,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 72,
                  width: 72,
                  child: Image.asset(
                    "assets/images/profile-pic-placeholder-card.png",
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          room.name,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Text(
                            room.lastMessage,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: Theme.of(context).disabledColor),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openChatPage(BuildContext context) {
    Navigator.pushNamed(context, "/chat_page");
  }
}
