import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vc_video_call/blocs/call/call_bloc.dart';
import 'package:vc_video_call/blocs/call/call_event.dart';
import 'package:vc_video_call/blocs/call/call_state.dart';
import 'package:vc_video_call/blocs/call_connecting/call_connecting_bloc.dart';
import 'package:vc_video_call/blocs/call_connecting/call_connecting_state.dart';
import 'package:vc_video_call/services/web_rtc_manager.dart';

class CallPage extends StatefulWidget {
  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CallConnectingBloc, CallConnectingState>(
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.switch_camera),
                    onPressed: () {
                      setState(() {
                        state.localRenderer.srcObject
                            .getVideoTracks()
                            .forEach((track) {
                          track.switchCamera();
                        });
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: state.status == CallConnectingStatus.success
                      ? RTCVideoView(state.remoteRenderer)
                      : Center(child: CircularProgressIndicator()),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: RTCVideoView(
                        RepositoryProvider.of<WebRtcManager>(context)
                            .localRenderer),
                    decoration: BoxDecoration(color: Colors.black54),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocBuilder<CallBloc, CallState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32.0, left: 32, right: 32),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    onPressed: toggleAudio(state, context),
                    heroTag: null,
                    tooltip: 'Mic',
                    child: state.audioEnabled
                        ? Icon(Icons.mic)
                        : Icon(Icons.mic_off),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: toggleVideo(state, context),
                    heroTag: null,
                    tooltip: 'Video',
                    child: state.videoEnabled
                        ? Icon(Icons.videocam)
                        : Icon(Icons.videocam_off),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      context.read<CallBloc>().add(
                          CallEndedEvent(state.roomId, state.peerConnection));
                    },
                    backgroundColor: Colors.red,
                    heroTag: null,
                    tooltip: 'End Call',
                    child: Icon(Icons.call_end),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Function toggleVideo(CallState state, BuildContext context) {
    return state.status == CallStatus.inProgress
        ? () {
            context.read<CallBloc>().add(CallVideoToggledEvent());
          }
        : null;
  }

  Function toggleAudio(CallState state, BuildContext context) {
    return state.status == CallStatus.inProgress
        ? () {
            context.read<CallBloc>().add(CallAudioToggledEvent());
          }
        : null;
  }
}
