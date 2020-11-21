import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
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
            Align(
              alignment: Alignment.topRight,
              child: Text(
                "18/11/20",
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
                      "assets/images/profile-pic-placeholder-card.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Juan Dela Cruz",
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Last message sent.",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Theme.of(context).disabledColor),
                        textAlign: TextAlign.left,
                      ),
                    ],
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
