import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vc_video_call/blocs/login/login_bloc.dart';
import 'package:vc_video_call/services/login_service.dart';
import 'package:vc_video_call/app_routes.dart';

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
        RepositoryProvider<LoginService>(
          create: (context) => LoginService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (BuildContext context) =>
                LoginBloc(context.read<LoginService>()),
          )
        ],
        child: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return MaterialApp(
                  title: 'Vc Video Call',
                  theme: theme,
                  onGenerateRoute: AppRoutes.onGenerateRoute,
                );
              }
              return Scaffold(
                body: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
