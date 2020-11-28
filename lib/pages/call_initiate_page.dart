import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vc_video_call/blocs/call_initiate/call_initiate_bloc.dart';
import 'package:vc_video_call/blocs/call_initiate/call_initiate_state.dart';
import 'package:vc_video_call/services/web_rtc_manager.dart';

class CallInitiatePage extends StatefulWidget {
  @override
  _CallInitiatePageState createState() => _CallInitiatePageState();
}

class _CallInitiatePageState extends State<CallInitiatePage> {
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
              child: BlocBuilder<CallInitiateBloc, CallInitiateState>(
                builder: (context, state) {
                  if (state.status == CallInitiateStatus.inProgress) {
                    return RTCVideoView(state.localRenderer);
                  }
                  return Container();
                },
              ),
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
