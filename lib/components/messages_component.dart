import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/get_messages/get_messages_bloc.dart';
import 'package:vc_video_call/blocs/get_messages/get_messages_state.dart';
import 'package:vc_video_call/components/receiver_message_card.dart';
import 'package:vc_video_call/components/sender_message_card.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

class MessagesComponent extends StatefulWidget {
  const MessagesComponent({
    Key key,
    @required this.room,
    @required this.messages,
  }) : super(key: key);

  final List<Message> messages;
  final Room room;

  @override
  _MessagesComponentState createState() => _MessagesComponentState();
}

class _MessagesComponentState extends State<MessagesComponent> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.room.status != RoomStatus.RoomAccepted &&
        widget.room.status != RoomStatus.RoomInvitePending) {
      return SizedBox.shrink();
    }

    return Expanded(
      child: BlocListener<GetMessagesBloc, GetMessagesState>(
        listener: (context, state) {
          if (state.status == GetMessagesStatus.success) {
            setState(() {
              if (widget.messages.isEmpty) {
                for (var message in state.getMessagesResponse.messages) {
                  widget.messages.add(message);
                }
              } else {
                for (var message in state.getMessagesResponse.messages) {
                  if (!widget.messages
                      .any((element) => element.id == message.id)) {
                    widget.messages.insert(0, message);
                    _scrollController.animateTo(
                      0.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
                  }
                }
              }
            });
          }
        },
        child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: widget.messages.length ?? 0,
          reverse: true,
          itemBuilder: (context, i) {
            Widget card;

            Message message = widget.messages[i];
            if (message.senderId ==
                BlocProvider.of<GetMessagesBloc>(context).state.userId) {
              card = SenderMessageCard(message);
            } else {
              card = ReceiverMessageCard(message);
            }
            return card;
          },
        ),
      ),
    );
  }
}
