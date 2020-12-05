import 'package:flutter/material.dart';
import 'package:vc_video_call/components/online_indicator.dart';

class DefaultCircleAvatar extends StatelessWidget {
  const DefaultCircleAvatar({
    Key key,
    this.isOnline = true,
    this.radius = 36,
    this.child,
    this.image,
  }) : super(key: key);

  final bool isOnline;
  final double radius;
  final Widget child;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    //double indicatorMargin = radius * 0.11;
    return Container(
      height: radius * 2,
      width: radius * 2,
      child: Stack(
        children: [
          CircleAvatar(
            radius: radius,
            child: this.child,
            backgroundImage: image,
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: radius * 0.1,
                  bottom: radius * 0.1,
                ),
                child: Container(
                  height: radius * 0.5,
                  width: radius * 0.5,
                  child: OnlineIndicator(isOnline),
                ),
              )),
        ],
      ),
    );
  }
}
