import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/join/join_bloc.dart';
import 'package:vc_video_call/blocs/join/join_state.dart';

class ConnectionStatusIndicatorComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JoinBloc, JoinState>(
      builder: (context, state) {
        switch (state.status) {
          case JoinStatus.inProgress:
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(4),
              child: Center(
                child: SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
            break;
          case JoinStatus.failure:
            return Container(
              width: double.infinity,
              color: Theme.of(context).errorColor,
              child: Center(
                child: Text(
                  state.errorMessage,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Theme.of(context).colorScheme.onError,
                      ),
                ),
              ),
            );
            break;
          default:
            return Container();
        }
      },
    );
  }
}
