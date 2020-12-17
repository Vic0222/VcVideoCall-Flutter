import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/send_message_bloc/send_message_bloc.dart';
import 'package:vc_video_call/blocs/send_message_bloc/send_message_state.dart';
import 'package:vc_video_call/grpc/generated/chat.pb.dart';

class MessageSenderComponent extends StatefulWidget {
  MessageSenderComponent({
    Key key,
    @required this.room,
  }) : super(key: key);

  final Room room;

  @override
  _MessageSenderComponentState createState() => _MessageSenderComponentState();
}

class _MessageSenderComponentState extends State<MessageSenderComponent> {
  bool textfieldEnabled;
  TextEditingController chatTextEditingController;

  @override
  void initState() {
    super.initState();
    chatTextEditingController = TextEditingController();
    textfieldEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.room.status != RoomStatus.RoomAccepted,
      child: Container(
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
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (text) {
                    setState(() {
                      textfieldEnabled = text?.isNotEmpty ?? false;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Aa",
                    hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Theme.of(context).disabledColor,
                        ),
                  ),
                  controller: chatTextEditingController,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
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
                            onPressed: !textfieldEnabled &&
                                    widget.room.status ==
                                        RoomStatus.RoomAccepted
                                ? null
                                : () {
                                    context
                                        .read<SendMessageBloc>()
                                        .startSendMessage(
                                          widget.room.id,
                                          chatTextEditingController.text,
                                        );
                                    setState(() {
                                      chatTextEditingController.clear();
                                    });
                                  },
                          )
                        : CircularProgressIndicator();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
