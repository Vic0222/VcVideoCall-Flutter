import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/call_listening/call_listening_bloc.dart';
import 'package:vc_video_call/blocs/call_listening/call_listening_event.dart';
import 'package:vc_video_call/blocs/call_listening/call_listening_state.dart';

class CallReceivedPage extends StatefulWidget {
  @override
  _CallReceivedPageState createState() => _CallReceivedPageState();
}

class _CallReceivedPageState extends State<CallReceivedPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallListeningBloc, CallListeningState>(
      builder: (blocContext, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            color: Theme.of(blocContext).primaryColor,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  width: MediaQuery.of(blocContext).size.width,
                  height: MediaQuery.of(blocContext).size.height,
                  decoration: BoxDecoration(
                    color: Theme.of(blocContext).primaryColor,
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
                        style: Theme.of(blocContext)
                            .textTheme
                            .headline6
                            .copyWith(
                              color:
                                  Theme.of(blocContext).colorScheme.onPrimary,
                            ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CallListeningBloc>(context)
                  .add(CallListningCallAccepted(state.callOfferNotification));
            },
          ),
        );
      },
    );
  }
}
