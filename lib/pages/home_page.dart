import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/getrooms/get_rooms_bloc.dart';
import 'package:vc_video_call/blocs/getrooms/get_rooms_state.dart';
import 'package:vc_video_call/blocs/join/join_bloc.dart';
import 'package:vc_video_call/blocs/join/join_state.dart';
import 'package:vc_video_call/blocs/profilepic/profilepic_bloc.dart';
import 'package:vc_video_call/blocs/profilepic/profilepic_event.dart';
import 'package:vc_video_call/blocs/profilepic/profilepic_state.dart';
import 'package:vc_video_call/components/contact_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 40, maxWidth: 200),
          child: BlocBuilder<ProfilePicBloc, ProfilePicState>(
              builder: (context, state) {
            if (state.status == GetProfilePicStatus.initial) {
              BlocProvider.of<ProfilePicBloc>(context)
                  .add(ProfilePicEvent.GetProfilePicStarted);
            }
            switch (state.status) {
              case GetProfilePicStatus.success:
                return Container(
                  height: 40,
                  width: 40,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                        state.photoURL,
                      ),
                    ),
                  ),
                );
                break;
              default:
                return Image(
                  image:
                      AssetImage("assets/images/profile-pic-placeholder.png"),
                );
            }
          }),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<JoinBloc, JoinState>(
        listener: (context, state) {
          if (state.status == JoinStatus.success) {
            BlocProvider.of<GetRoomsBloc>(context).startGetRooms();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              checkAndDisplayError(context, state),
              Expanded(
                child: BlocBuilder<GetRoomsBloc, GetRoomsState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case GetRoomsStatus.success:
                        return ListView.builder(
                          itemCount: state.getRoomsResponse.rooms.length,
                          itemBuilder: (context, index) {
                            return ContactCard(
                                state.getRoomsResponse.rooms[index]);
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
          );
        },
      ),
    );
  }

  Widget checkAndDisplayError(BuildContext context, JoinState state) {
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
