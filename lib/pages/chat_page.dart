import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/call_initiate/call_initiate_bloc.dart';
import 'package:vc_video_call/blocs/call_initiate/call_initiate_state.dart';
import 'package:vc_video_call/blocs/get_messages/get_messages_bloc.dart';
import 'package:vc_video_call/blocs/get_messages/get_messages_state.dart';
import 'package:vc_video_call/blocs/send_message_bloc/send_message_bloc.dart';
import 'package:vc_video_call/blocs/send_message_bloc/send_message_state.dart';
import 'package:vc_video_call/components/connection_status_indicator.dart';
import 'package:vc_video_call/components/default_circle_avatar.dart';
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
    return BlocListener<CallInitiateBloc, CallInitiateState>(
      listener: (context, state) {
        if (state.status == CallInitiateStatus.inProgress) {
          Navigator.of(context)
              .pushNamed("/call_initiate", arguments: state.localRenderer);
        }
      },
      child: buildScaffold(context),
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
                  .startCallInitiate(widget.room.id, false);
            },
          ),
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {
              context
                  .read<CallInitiateBloc>()
                  .startCallInitiate(widget.room.id, true);
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
              isOnline: widget.room.isOnline,
              radius: 20,
              image:
                  AssetImage("assets/images/profile-pic-placeholder-card.png"),
            ),
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
          BlocBuilder<GetMessagesBloc, GetMessagesState>(
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
          ),
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
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Container(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (text) {
                          setState(() {
                            textfieldEnabled = text?.isNotEmpty ?? false;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
