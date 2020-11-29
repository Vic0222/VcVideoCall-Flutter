import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vc_video_call/blocs/call/call_connecting_bloc.dart';
import 'package:vc_video_call/blocs/call/call_connecting_state.dart';

class CallPage extends StatefulWidget {
  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CallConnectingBloc, CallConnectingState>(
        builder: (context, state) {
          if (state.status != CallConnectingStatus.success) {
            return Container();
          }
          return Center(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.switch_camera),
                    onPressed: () {
                      setState(() {
                        state.localRenderer.srcObject
                            .getVideoTracks()[0]
                            .switchCamera();
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: RTCVideoView(state.remoteRenderer),
                  decoration: BoxDecoration(color: Colors.black54),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: RTCVideoView(state.localRenderer),
                    decoration: BoxDecoration(color: Colors.black54),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
