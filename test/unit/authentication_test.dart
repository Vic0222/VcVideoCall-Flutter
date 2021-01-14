// Import the test package and Counter class
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vc_video_call/blocs/authentication/authentication_bloc.dart';
import 'package:vc_video_call/blocs/authentication/authentication_event.dart';

import '../mocks/MockAuthenticationService.dart';

void main() {
  group("test authentication bloc", () {
    MockAuthenticationService mockAuthenticationService;
    AuthenticationBloc authenticationBloc;
    setUp(() {
      mockAuthenticationService = MockAuthenticationService();
      when(mockAuthenticationService.signInWithGoogle())
          .thenAnswer((realInvocation) => Future.value(true));

      authenticationBloc = AuthenticationBloc(mockAuthenticationService);
    });

    test("call sign in with goole", () {});

    blocTest("call google signin",
        build: () => authenticationBloc,
        act: (bloc) => bloc.add(AuthenticationEvent.authenticationStarted),
        verify: (_) {
          verify(mockAuthenticationService.signInWithGoogle()).called(1);
        });
  });
}
