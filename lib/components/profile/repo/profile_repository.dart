import 'profile.dart';

abstract class ProfileRepository {
  Future<void> create({
    Profile profile,
  });
  Future<void> update({
    Profile profile,
  });
  Future<void> setDesc({String desc});
  Future<Profile> get();
  Future<void> delete();
  Future<bool> exists();
  Stream<Profile> get profileStream;
}
