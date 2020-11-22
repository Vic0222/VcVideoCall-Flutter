import 'package:flutter/material.dart';

class ReceiverMessageCard extends StatelessWidget {
  const ReceiverMessageCard({
    Key key,
  }) : super(key: key);

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
            "Op? SLong text for place holder? a b casd asd asdw a2 sasad",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
