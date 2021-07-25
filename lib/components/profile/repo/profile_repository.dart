import 'package:flutter/material.dart';
import 'profile.dart';

abstract class ProfileRepository {
  Future<void> create({
    required Profile profile,
  });
  Future<void> update({
    required Profile profile,
  });
  Future<Profile> get();
  Future<void> delete();
  Future<bool> exists();
  Stream<Profile> get profileStream;
}
