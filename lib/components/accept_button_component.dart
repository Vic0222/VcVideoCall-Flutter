import 'package:flutter/material.dart';

class AcceptButtonComponent extends StatelessWidget {
  final VoidCallback onPressed;

  const AcceptButtonComponent({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          "Accept",
          style: Theme.of(context).textTheme.button.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
