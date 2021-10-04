import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zample/core/repo/auth_repository.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  FirebaseAuthRepository({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
    FacebookAuth facebookAuth,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _facebookAuth = facebookAuth ?? FacebookAuth.instance;

  @override
  User getCurrentUser() {
    final User user = _firebaseAuth.currentUser;
    if (null != user) {
      user.reload();
    }
    return user;
  }

  @override
  Future<UserCredential> logInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (null == googleUser) throw Exception("No Google User");
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserCredential> logInWithFacebook() async {
    final LoginResult loginResult = await _facebookAuth.login();
    final OAuthCredential credential = FacebookAuthProvider.credential(
      loginResult.accessToken.token,
    );
    return _firebaseAuth.signInWithCredential(credential);
  }
}
