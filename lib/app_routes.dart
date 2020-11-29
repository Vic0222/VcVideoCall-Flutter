import 'package:flutter/material.dart';
import 'package:vc_video_call/pages/call_initiate_page.dart';
import 'package:vc_video_call/pages/call_page.dart';
import 'package:vc_video_call/pages/call_received_page.dart';
import 'package:vc_video_call/pages/home_page.dart';
import 'package:vc_video_call/pages/login_page.dart';
import 'package:vc_video_call/pages/chat_page.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => LoginPage());
        break;
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/chat_page':
        return MaterialPageRoute(
            builder: (context) => ChatPage(settings.arguments));
      case '/call_initiate':
        return MaterialPageRoute(builder: (context) => CallInitiatePage());
      case '/call_received':
        return MaterialPageRoute(builder: (context) => CallReceivedPage());
      case '/call':
        return MaterialPageRoute(builder: (context) => CallPage());
      default:
        return null;
    }
  }
}
