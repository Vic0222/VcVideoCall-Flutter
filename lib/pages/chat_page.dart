import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/call_initiate/call_initiate_bloc.dart';
import 'package:vc_video_call/blocs/call_initiate/call_initiate_state.dart';
import 'package:vc_video_call/blocs/get_messages/get_messages_bloc.dart';
import 'package:vc_video_call/blocs/get_room/get_room_bloc.dart';
import 'package:vc_video_call/blocs/get_room/get_room_state.dart';
import 'package:vc_video_call/blocs/send_invite_accept/send_user_invite_bloc.dart';
import 'package:vc_video_call/blocs/send_user_invite/send_user_invite_bloc.dart';
import 'package:vc_video_call/blocs/send_user_invite/send_user_invite_state.dart';
import 'package:vc_video_call/components/connection_status_indicator.dart';
import 'package:vc_video_call/components/decline_button_component.dart';
import 'package:vc_video_call/components/default_circle_avatar.dart';
import 'package:vc_video_call/components/default_progress_indicator.dart';
import 'package:vc_video_call/components/get_messages_indicator_component.dart';
import 'package:vc_video_call/components/accept_button_component.dart';
import 'package:vc_video_call/components/invite_button_component.dart';
import 'package:vc_video_call/components/message_sender_component.dart';
import 'package:vc_video_call/components/messages_component.dart';
import 'package:vc_video_call/custom_classes/custom_color_scheme.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

class ChatPage extends StatefulWidget {
  final Room room;
  final String userId;

  ChatPage({this.room, this.userId = ""});

  @override
  _ChatPageState createState() => _ChatPageState(room: room);
}

class _ChatPageState extends State<ChatPage> {
  _ChatPageState({this.room});

  Room room;

  final List<Message> _messages = List<Message>();

  StreamSubscription<GetRoomState> _getRoomSubscription;

  @override
  void initState() {
    super.initState();

    if (room?.id?.isNotEmpty ?? false) {
      context.read<GetMessagesBloc>().startGetMessages(room.id);
    }

    context
        .read<GetRoomBloc>()
        .startGetRoom(this.widget.userId, this.widget?.room?.id);
  }

  @override
  void dispose() {
    _getRoomSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CallInitiateBloc, CallInitiateState>(
          listener: (context, state) {
            if (state.status == CallInitiateStatus.inProgress) {
              Navigator.of(context)
                  .pushNamed("/call_initiate", arguments: state.localRenderer);
            }
          },
        ),
        BlocListener<GetRoomBloc, GetRoomState>(
          listener: (context, state) {
            if (state.status == GetRoomStatus.success) {
              setState(() {
                this.room = state.room;
              });
              if (room != null) {
                context.read<GetMessagesBloc>().startGetMessages(room.id);
              }
            }
          },
        ),
        BlocListener<SendUserInviteBloc, SendUserInviteState>(
          listener: (context, state) {
            if (state.status == SendUserInviteStatus.success) {
              setState(() {
                this.room = state.room;
              });
              if (room != null) {
                context.read<GetMessagesBloc>().startGetMessages(room.id);
              }
            }
          },
        ),
      ],
      child: BlocBuilder<GetRoomBloc, GetRoomState>(builder: (context, state) {
        if (state.status == GetRoomStatus.success) {
          return buildScaffold(context);
        }
        return Scaffold(body: DefaultProgressIndicator());
      }),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              context
                  .read<CallInitiateBloc>()
                  .startCallInitiate(room.id, false);
            },
          ),
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {
              context.read<CallInitiateBloc>().startCallInitiate(room.id, true);
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        title: Row(
          children: [
            DefaultCircleAvatar(
              isOnline: room?.isOnline ?? false,
              radius: 20,
              image: room?.photoUrl?.isEmpty ?? true
                  ? AssetImage("assets/images/profile-pic-placeholder-card.png")
                  : NetworkImage(room?.photoUrl ?? ""),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Online",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryDeEmphasize,
                          ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: buildBody(context),
    );
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: [
        ConnectionStatusIndicatorComponent(),
        GetMessagesIndicatorComponent(),
        _buildInviteButtons(context),
        Expanded(child: MessagesComponent(room: room, messages: _messages)),
        MessageSenderComponent(room: room),
      ],
    );
  }

  Widget _buildInviteButtons(BuildContext context) {
    Widget inviteButtons = Container();
    if (room.status == RoomStatus.RoomNotExisting) {
      inviteButtons = Padding(
        padding: const EdgeInsets.all(8.0),
        child: InviteButtonComponent(
          onPressed: () {
            _doInviteUser(context);
          },
        ),
      );
    } else if (room.status == RoomStatus.RoomAcceptPending) {
      inviteButtons = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AcceptButtonComponent(
                onPressed: () {},
              ),
              DeclineButtonComponent(),
            ],
          ),
        ),
      );
    } else if (room.status == RoomStatus.RoomInvitePending) {
      inviteButtons = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Chat Invite Pending"),
        ),
      );
    }

    return inviteButtons;
  }

  void _doInviteUser(BuildContext context) {
    context.read<SendUserInviteBloc>().startSendUserInvite(widget.userId);
  }

  void _doAcceptInvite(BuildContext context) {
    context.read<SendInviteAcceptBloc>().startSendInviteAccept(widget.userId);
  }
}
