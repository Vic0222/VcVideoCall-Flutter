import 'package:flutter/material.dart';

class DefaultProgressIndicator extends StatelessWidget {
  const DefaultProgressIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
