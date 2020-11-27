import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/get_messages/get_messages_bloc.dart';
import 'package:vc_video_call/blocs/get_messages/get_messages_state.dart';
import 'package:vc_video_call/blocs/send_message_bloc/send_message_bloc.dart';
import 'package:vc_video_call/blocs/send_message_bloc/send_message_state.dart';
import 'package:vc_video_call/components/connection_status_indicator.dart';
import 'package:vc_video_call/components/receiver_message_card.dart';
import 'package:vc_video_call/components/sender_message_card.dart';
import 'package:vc_video_call/custom_classes/custom_color_scheme.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

class ChatPage extends StatefulWidget {
  final Room room;

  ChatPage(this.room);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _chatTextEditingController;
  ScrollController _scrollController;
  bool textfieldEnabled = true;

  final List<Message> _messages = List<Message>();

  @override
  void initState() {
    super.initState();
    _chatTextEditingController = TextEditingController();

    _scrollController = ScrollController();

    context.read<GetMessagesBloc>().startGetMessages(widget.room.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        title: Row(
          children: [
            Image.asset("assets/images/profile-pic-placeholder.png"),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.room.name,
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
      body: Column(
        children: [
          ConnectionStatusIndicator(),
          Expanded(
            child: BlocListener<GetMessagesBloc, GetMessagesState>(
              listener: (context, state) {
                if (state.status == GetMessagesStatus.success) {
                  setState(() {
                    if (_messages.isEmpty) {
                      for (var message in state.getMessagesResponse.messages) {
                        _messages.add(message);
                      }
                    } else {
                      for (var message in state.getMessagesResponse.messages) {
                        if (!_messages
                            .any((element) => element.id == message.id)) {
                          _messages.insert(0, message);
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
                itemCount: _messages.length ?? 0,
                reverse: true,
                itemBuilder: (context, i) {
                  Widget widget;

                  Message message = _messages[i];
                  if (message.senderId ==
                      BlocProvider.of<GetMessagesBloc>(context).state.userId) {
                    widget = SenderMessageCard(message);
                  } else {
                    widget = ReceiverMessageCard(message);
                  }
                  return widget;
                },
              ),
            ),
          ),
          Container(
            height: 56,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            textfieldEnabled = text?.isNotEmpty ?? false;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Aa",
                          hintStyle:
                              Theme.of(context).textTheme.bodyText1.copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                        ),
                        controller: _chatTextEditingController,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: BlocConsumer<SendMessageBloc, SendMessageState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return state.status != SendMessageStatus.inProgress
                            ? IconButton(
                                icon: Icon(Icons.send),
                                color: Theme.of(context).colorScheme.onPrimary,
                                onPressed: !textfieldEnabled
                                    ? null
                                    : () {
                                        context
                                            .read<SendMessageBloc>()
                                            .startSendMessage(
                                              widget.room.id,
                                              _chatTextEditingController.text,
                                            );
                                        setState(() {
                                          _chatTextEditingController.clear();
                                        });
                                      },
                              )
                            : CircularProgressIndicator();
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
