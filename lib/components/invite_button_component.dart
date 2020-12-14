import 'package:flutter/material.dart';

class InviteButtonComponent extends StatelessWidget {
  const InviteButtonComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () {},
        child: Text(
          "Invite to chat",
          style: Theme.of(context).textTheme.button.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
