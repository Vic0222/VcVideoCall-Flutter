import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:vc_video_call/blocs/login/login_bloc.dart';
import 'package:vc_video_call/blocs/login/login_event.dart';
import 'package:vc_video_call/blocs/login/login_state.dart';
import 'package:vc_video_call/components/logo.dart';
import 'package:vc_video_call/services/login_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state.status == LoginStatus.failure) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(state?.errorMessage)));
      } else if (state.status == LoginStatus.success) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    }, builder: (context, state) {
      return Scaffold(
        body: state.status == LoginStatus.inProgress
            ? buildLoading(context)
            : buildContent(context),
      );
    });
  }

  Stack buildContent(BuildContext context) {
    return Stack(
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
    );
  }

  Stack buildLoading(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }

  void login(BuildContext context) {
    context.read<LoginBloc>().add(LoginEvent.loginStarted);
  }
}
