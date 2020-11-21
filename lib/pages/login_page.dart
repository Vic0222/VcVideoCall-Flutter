import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:vc_video_call/components/logo.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Logo(),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 460),
              child: SizedBox(
                height: 40,
                child: SignInButton(
                  Buttons.Google,
                  onPressed: () {
                    login(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }
}
