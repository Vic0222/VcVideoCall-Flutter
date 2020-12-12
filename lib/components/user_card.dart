import 'package:flutter/material.dart';
import 'package:vc_video_call/components/default_circle_avatar.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

class UserCard extends StatelessWidget {
  UserCard(this.user);

  final User user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openChatPage(context);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: [
            Row(
              children: [
                DefaultCircleAvatar(
                  radius: 25,
                  isOnline: false,
                  image: user.photoUrl?.isEmpty ?? true
                      ? AssetImage(
                          "assets/images/profile-pic-placeholder-card.png")
                      : NetworkImage(user.photoUrl),
                ),
                Flexible(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 0,
                            child: Container(
                              child: Text(
                                user.username,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
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
    Navigator.pushNamed(context, "/chat_page",
        arguments: {"room": null, "userId": this.user?.userId ?? ""});
  }
}
