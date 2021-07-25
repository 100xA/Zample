import 'package:get_it/get_it.dart';
import 'package:zample/components/profile/repo/firebase_profile_repository.dart';
import 'package:zample/components/profile/repo/profile_repository.dart';
import 'package:zample/core/bloc/app/app_cubit.dart';
import 'package:zample/core/bloc/auth/cubit/auth_cubit.dart';
import 'package:zample/core/bloc/theme/theme_cubit.dart';
import 'package:zample/core/repo/auth_repository.dart';
import 'package:zample/core/repo/firebase_auth_repository.dart';
import 'package:zample/core/services/navigator_service.dart';
import 'package:zample/core/services/shared_preferences_service.dart';

final GetIt app = GetIt.instance;

void setupServices() {
  app
    ..registerLazySingleton<ProfileRepository>(
        () => FirebaseProfileRepository())
    ..registerLazySingleton<AuthRepository>(() => FirebaseAuthRepository())
    ..registerLazySingleton<AppCubit>(() => AppCubit())
    ..registerLazySingleton<AuthCubit>(() => AuthCubit())
    ..registerLazySingleton<NavigatorService>(() => NavigatorService())
    ..registerLazySingleton<SharedPreferencesService>(
        () => SharedPreferencesService())
    ..registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
