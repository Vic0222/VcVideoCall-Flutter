import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vc_video_call/blocs/firebase_initialize/firebase_initialize_bloc.dart';
import 'package:vc_video_call/blocs/getrooms/get_rooms_bloc.dart';
import 'package:vc_video_call/blocs/join/join_bloc.dart';
import 'package:vc_video_call/blocs/profilepic/profilepic_bloc.dart';
import 'package:vc_video_call/services/authentication_service.dart';
import 'package:vc_video_call/blocs/authentication/authentication_bloc.dart';
import 'package:vc_video_call/app_routes.dart';
import 'package:vc_video_call/services/chat_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

    return buildMaterialApp(theme);
  }

  Widget buildMaterialApp(ThemeData theme) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseAuth>(
          create: (context) => FirebaseAuth.instance,
        ),
        RepositoryProvider<GoogleSignIn>(
          create: (context) => GoogleSignIn(),
        ),
        RepositoryProvider<AuthenticationService>(
          create: (context) => AuthenticationService(),
        ),
        RepositoryProvider<ChatService>(
          create: (context) => ChatService(
            context.read<AuthenticationService>(),
            "10.0.2.2",
            80,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) =>
                AuthenticationBloc(context.read<AuthenticationService>()),
          ),
          BlocProvider<JoinBloc>(
            create: (BuildContext context) =>
                JoinBloc(context.read<ChatService>()),
          ),
          BlocProvider<GetRoomsBloc>(
            create: (BuildContext context) =>
                GetRoomsBloc(context.read<ChatService>()),
          ),
          BlocProvider<ProfilePicBloc>(
            create: (BuildContext context) =>
                ProfilePicBloc(context.read<AuthenticationService>()),
          ),
          BlocProvider<FirebaseInitializeBloc>(
            create: (BuildContext context) =>
                FirebaseInitializeBloc(context.read<AuthenticationService>()),
          ),
        ],
        child: MaterialApp(
          title: 'Vc Video Call',
          theme: theme,
          initialRoute: '/',
          navigatorKey: AppRoutes.navigatorKey,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}
