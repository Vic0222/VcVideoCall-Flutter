import 'package:flutter/material.dart';

class DeclineButtonComponent extends StatelessWidget {
  const DeclineButtonComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () {},
        child: Text(
          "Decline",
        ),
      ),
    );
  }
}
