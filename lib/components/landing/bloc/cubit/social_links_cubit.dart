import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:zample/components/home/ui/home_screen.dart';
import 'package:zample/components/landing/bloc/cubit/social_links_state.dart';

import 'package:zample/core/bloc/auth/cubit/auth_cubit.dart';
import 'package:zample/core/repo/auth_repository.dart';
import 'package:zample/core/services/navigator_service.dart';
import 'package:zample/core/services/service_locator.dart';

class SocialLinksCubit extends Cubit<SocialLinksState> {
  final AuthRepository _authRepository = app.get<AuthRepository>();
  final AuthCubit _authCubit = app.get<AuthCubit>();

  final NavigatorService _navigatorService = app.get<NavigatorService>();

  SocialLinksCubit() : super(const SocialLinksState());

  String error =
      "Es ist ein Fehler bei der Anmeldung aufgetreten, oder du hast dich mit einem anderem Service angemeldet!";
  Future<void> logInWithGoogle() async {
    emit(state.copyWith(error: "", loading: true));

    String error =
        "Es ist ein Fehler bei der Anmeldung aufgetreten, oder du hast dich mit einem anderem Service angemeldet!";
    try {
      await _authRepository.logInWithGoogle();
      emit(state.copyWith(error: "", loading: false));
      await _authCubit.initialize();
      _navigatorService.pushReplacementNamed(HomeScreen.route);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "account-exists-with-different-credential":
          error = "Die E-Mail wurde schon über eine ander Anmeldung verwendet!";
          break;
      }
      emit(state.copyWith(error: error, loading: false));
    } catch (e) {
      emit(state.copyWith(error: error, loading: false));
      FirebaseCrashlytics.instance.recordError(e, null);
    }
  }

  Future<void> logInWithFacebook() async {
    emit(state.copyWith(error: "", loading: true));
    String error =
        "Es ist ein Fehler bei der Anmeldung aufgetreten, oder du hast dich mit einem anderem Service angemeldet!";
    try {
      await _authRepository.logInWithFacebook();
      await _authCubit.initialize();

      _navigatorService.pushReplacementNamed(HomeScreen.route);
      emit(state.copyWith(error: "", loading: false));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        default:
          error =
              "Die E-Mail wurde schon über eine ander Anmeldung verwendet, oder du hast dich mit einem anderem Service angemeldet!";
          break;
      }
      emit(state.copyWith(error: error, loading: false));
    } catch (e) {
      emit(state.copyWith(error: error, loading: false));
      FirebaseCrashlytics.instance.recordError(e, null);
    }
  }

  /// No Login needs to be reworked, see #3
  Future<void> noLogin() async {
    emit(state.copyWith(error: "", loading: true, authenticated: false));

    try {
      _navigatorService.pushReplacementNamed(HomeScreen.route);
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
          loading: false,
          authenticated: false,
        ),
      );
      FirebaseCrashlytics.instance.recordError(e, null);
    }
  }
}
