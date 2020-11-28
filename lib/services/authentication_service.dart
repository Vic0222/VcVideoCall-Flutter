import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  AuthenticationService({firebaseAuth, googleSignIn})
      : _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future initialize() async {
    await Firebase.initializeApp();
    _firebaseAuth = FirebaseAuth.instance;
  }

  FirebaseAuth _firebaseAuth;

  final GoogleSignIn _googleSignIn;

  Future<bool> signInWithGoogle() async {
    bool success = false;
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      success = true;
    }

    return success;
  }

  Future<String> getToken() async {
    return await _firebaseAuth?.currentUser?.getIdToken() ?? "";
  }

  String getUserPhotoURL() {
    return _firebaseAuth?.currentUser?.photoURL ?? "";
  }

  String getUserId() {
    return _firebaseAuth?.currentUser?.uid ?? "";
  }
}
