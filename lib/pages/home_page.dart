import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/chat/chat_bloc.dart';
import 'package:vc_video_call/blocs/chat/chat_state.dart';
import 'package:vc_video_call/components/contact_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {},
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
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ContactCard();
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
    return state.status != JoinStatus.failure
        ? Container()
        : Container(
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
  }
}
