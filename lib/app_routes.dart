import 'package:flutter/material.dart';
import 'package:vc_video_call/pages/home_page.dart';
import 'package:vc_video_call/pages/login_page.dart';
import 'package:vc_video_call/pages/chat_page.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => LoginPage());
        break;
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/chat_page':
        return MaterialPageRoute(builder: (context) => ChatPage());
      default:
        return null;
    }
  }
}
