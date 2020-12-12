import 'package:flutter/material.dart';
import 'package:vc_video_call/grpc/generated/chat.pbgrpc.dart';
import 'package:vc_video_call/pages/call_initiate_page.dart';
import 'package:vc_video_call/pages/call_page.dart';
import 'package:vc_video_call/pages/call_received_page.dart';
import 'package:vc_video_call/pages/home_page.dart';
import 'package:vc_video_call/pages/login_page.dart';
import 'package:vc_video_call/pages/chat_page.dart';
import 'package:vc_video_call/pages/search_user_page.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => LoginPage(),
            settings: RouteSettings(name: settings.name));
        break;
      case '/home':
        return MaterialPageRoute(
            builder: (context) => HomePage(),
            settings: RouteSettings(name: settings.name));
      case '/chat_page':
        Map<String, Object> arguments =
            settings.arguments as Map<String, Object>;
        return MaterialPageRoute(
            builder: (context) => ChatPage(
                  room: arguments["room"] as Room,
                  userId: arguments["userId"],
                ),
            settings: RouteSettings(name: settings.name));
      case '/call_initiate':
        return MaterialPageRoute(
            builder: (context) => CallInitiatePage(),
            settings: RouteSettings(name: settings.name));
      case '/call_received':
        return MaterialPageRoute(
            builder: (context) => CallReceivedPage(),
            settings: RouteSettings(name: settings.name));
      case '/call':
        return MaterialPageRoute(
            builder: (context) => CallPage(),
            settings: RouteSettings(name: settings.name));
      case '/search_user':
        return MaterialPageRoute(
            builder: (context) => SearchUserPage(),
            settings: RouteSettings(name: settings.name));
      default:
        return null;
    }
  }
}
