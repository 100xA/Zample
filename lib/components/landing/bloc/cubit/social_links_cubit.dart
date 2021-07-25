import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:zample/components/landing/bloc/cubit/social_links_state.dart';

import 'package:zample/core/bloc/auth/cubit/auth_cubit.dart';
import 'package:zample/core/repo/auth_repository.dart';
import 'package:zample/core/services/navigator_service.dart';
import 'package:zample/core/services/service_locator.dart';
import 'package:zample/zample_widgets/zample_test.dart';

class SocialLinksCubit extends Cubit<SocialLinksState> {
  final AuthRepository _authRepository = app.get<AuthRepository>();
  final AuthCubit _authCubit = app.get<AuthCubit>();

  final NavigatorService _navigatorService = app.get<NavigatorService>();

  SocialLinksCubit() : super(const SocialLinksState());
  Future<void> logInWithGoogle() async {
    emit(state.copyWith(error: "", loading: true));

    String error =
        "Es ist ein Fehler bei der Anmeldung aufgetreten, oder du hast dich mit einem anderem Service angemeldet!";
    try {
      final credentials = await _authRepository.logInWithGoogle();

      emit(state.copyWith(error: "", loading: false));
      await _authCubit.initialize();
      _navigatorService.pushReplacementNamed(ZampleTest.route);
      print("Worked");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "account-exists-with-different-credential":
          error = "Die E-Mail wurde schon über eine ander Anmeldung verwendet!";
          break;
      }
      emit(state.copyWith(error: error, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
      FirebaseCrashlytics.instance.recordError(e, null);
    }
  }
}
