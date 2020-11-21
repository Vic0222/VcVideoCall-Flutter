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
        child: Container(
          constraints: BoxConstraints(
            minHeight: 34,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(0),
            ),
          ),
          padding: EdgeInsets.all(8),
          child: Text(
            "What??? Filler words ss aa d dd asdasdads dsadasdw 2dasdads.",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
