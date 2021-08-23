import 'profile.dart';

abstract class ProfileRepository {
  Future<void> create({
    Profile profile,
  });
  Future<void> update({
    Profile profile,
  });

  Future<Profile> get();
  Future<void> delete();
  Future<void> deleteProfilePicture();
  Future<bool> exists();
  Stream<Profile> get profileStream;
}
