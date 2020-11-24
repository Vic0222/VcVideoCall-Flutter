import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/chat/chat_bloc.dart';
import 'package:vc_video_call/blocs/chat/chat_state.dart';
import 'package:vc_video_call/blocs/getrooms/get_rooms_bloc.dart';
import 'package:vc_video_call/blocs/getrooms/get_rooms_state.dart';
import 'package:vc_video_call/components/contact_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Center(
              child: Image(
                image: AssetImage("assets/images/profile-pic-placeholder.png"),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            children: [
              checkAndDisplayError(context, state),
              Expanded(
                child: BlocBuilder<GetRoomsBloc, GetRoomsState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case GetRoomsStatus.success:
                        return ListView.builder(
                          itemCount: state.roomListReply.rooms.length,
                          itemBuilder: (context, index) {
                            return ContactCard(
                                state.roomListReply.rooms[index]);
                          },
                        );
                        break;
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget checkAndDisplayError(BuildContext context, ChatState state) {
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
  }
}
