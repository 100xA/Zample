import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zample/components/profile/repo/profile.dart';
import 'package:zample/components/profile/repo/profile_repository.dart';
import 'package:zample/core/services/service_locator.dart';

class AuthCubit extends Cubit<dynamic> {
  AuthCubit() : super("");
  static const dogImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/api-6713394795660907811-739913.appspot.com/o/defaultAvatar%2Fdefault.jpg?alt=media&token=70d86d1c-0502-453c-815a-ad0fcd9b8ce4';

  Future<void> initialize() async {
    // Check if user is authenticated
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    final ProfileRepository _profileRepository = app.get<ProfileRepository>();

    if (null != firebaseUser) {
      // fetch profile for first time
      final bool exists = await _profileRepository.exists();

      // create user for the first time
      if (!exists) {
        final Profile profile = await _createDefaultProfile(firebaseUser);
        await _profileRepository.create(profile: profile);
      }
    }
  }

  Future<Profile> _createDefaultProfile(User usr) async {
    return Profile(
      avatarUrl: dogImageUrl,
      uid: usr.uid,
      //TODO: null operating
      email: usr.email ?? 'error',
      username:
          usr.displayName ?? usr.email!.substring(0, usr.email!.indexOf('@')),
    );
  }
}
