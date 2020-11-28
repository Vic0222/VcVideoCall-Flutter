import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/call_listening/call_listening_bloc.dart';
import 'package:vc_video_call/blocs/call_listening/call_listening_state.dart';

class CallReceivedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage(
                          "assets/images/profile-pic-placeholder.png",
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Calling name",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
