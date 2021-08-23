import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zample/components/landing/ui/landing_page.dart';
import 'package:zample/components/profile/bloc/cubit/profile_cubit.dart';
import 'package:zample/components/profile/repo/profile.dart';
import 'package:zample/components/profile/repo/profile_repository.dart';
import 'package:zample/core/repo/auth_repository.dart';
import 'package:zample/core/services/navigator_service.dart';
import 'package:zample/core/services/service_locator.dart';

class AuthCubit extends Cubit<dynamic> {
  AuthCubit() : super("");
  static const LightBulbImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/zample-95803.appspot.com/o/ressources%2Fexternal-content.duckduckgo.com.png?alt=media&token=c4048d1a-4d3a-471f-96eb-03b9d3c1a6a1';
  final AuthRepository _authRepository = app.get<AuthRepository>();
  final NavigatorService _navigatorService = app.get<NavigatorService>();
  Future<void> initialize() async {
    // Check if user is authenticated
    final User firebaseUser = FirebaseAuth.instance.currentUser;
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
      avatarUrl: LightBulbImageUrl,
      uid: usr.uid,
      email: usr.email,
      username:
          usr.displayName ?? usr.email.substring(0, usr.email.indexOf('@')),
      description: "Meine Beschreibung",
    );
  }

  Future<void> logOutRequested() async {
    await _authRepository.signOut();

    await app.get<ProfileCubit>().reset();

    // navigate to landing
    _navigatorService.pushReplacementNamed(LandingPage.route);
  }
}
