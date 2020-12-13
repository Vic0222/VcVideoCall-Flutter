import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/get_messages/get_messages_bloc.dart';
import 'package:vc_video_call/blocs/get_messages/get_messages_state.dart';

class GetMessagesIndicatorComponent extends StatelessWidget {
  const GetMessagesIndicatorComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMessagesBloc, GetMessagesState>(
      builder: (context, state) {
        if (state.status == GetMessagesStatus.inProgress) {
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
        }
        return Container();
      },
    );
  }
}
