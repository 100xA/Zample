import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> logInWithGoogle();
  Future<UserCredential> logInWithFacebook();
  Future<void> signOut();

  User getCurrentUser();
}
