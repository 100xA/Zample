import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthRepository {
  Future<UserCredential> logInWithGoogle();
  Future<UserCredential> logInWithFacebook();
  Future<void> signOut();

  User getCurrentUser();
}
