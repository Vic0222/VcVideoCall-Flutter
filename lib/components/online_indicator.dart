import 'package:flutter/material.dart';
import 'package:vc_video_call/custom_classes/custom_color_scheme.dart';

class OnlineIndicator extends StatelessWidget {
  OnlineIndicator(this.isOnline);
  final bool isOnline;
  @override
  Widget build(BuildContext context) {
    return isOnline
        ? CircleAvatar(
            foregroundColor: Theme.of(context).colorScheme.success,
            backgroundColor: Theme.of(context).colorScheme.success,
          )
        : Container();
  }
}
