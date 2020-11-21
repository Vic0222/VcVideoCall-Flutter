import 'package:flutter/material.dart';
import 'package:vc_video_call/pages/chat_page.dart';
import 'package:vc_video_call/pages/home_page.dart';
import 'package:vc_video_call/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData(
      primaryColor: Color(0xFF017068),
      accentColor: Color(0xFF728FB3),
      scaffoldBackgroundColor: Color(0xFFF4F7F4),
      backgroundColor: Color(0xFFF4F7F4),
      cardColor: Color(0xFFDADCDE),
      errorColor: Color(0xFFF44336),
      disabledColor: Color(0xFF999999),
      hintColor: Color(0xFF000000),
      // This makes the visual density adapt to the platform that you run
      // the app on. For desktop platforms, the controls will be smaller and
      // closer together (more dense) than on mobile platforms.
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    ColorScheme colorScheme = theme.colorScheme.copyWith(
      onPrimary: Color(0xFFF4F7F4),
      onBackground: Color(0xFF1D131E),
      onSurface: Color(0xFF1D131E),
    );
    theme = theme.copyWith(colorScheme: colorScheme);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/chat_page': (context) => ChatPage(),
      },
    );
  }
}
