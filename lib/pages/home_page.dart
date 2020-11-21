import 'package:flutter/material.dart';
import 'package:vc_video_call/components/contact_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ContactCard();
        },
      ),
    );
  }
}
