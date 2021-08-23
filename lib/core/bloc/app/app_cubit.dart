import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zample/core/bloc/app/app_state.dart';
import 'package:zample/core/bloc/auth/cubit/auth_cubit.dart';
import 'package:zample/core/services/service_locator.dart';

class AppCubit extends Cubit<AppState> {
  final AuthCubit _authCubit = app.get<AuthCubit>();

  AppCubit() : super(const AppState());

  Future<void> initializeApp() async {
    emit(state.copyWith(loading: true));

    try {
      // initialize authentication
      _authCubit.initialize();
    } catch (e) {
      emit(state.copyWith(errorMsg: e.toString()));
      FirebaseCrashlytics.instance.recordError(e, null);
    }
    emit(state.copyWith(loading: false));
  }
}
