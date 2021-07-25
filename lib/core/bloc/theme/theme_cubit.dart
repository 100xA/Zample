import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:zample/core/bloc/theme/theme_state.dart';
import 'package:zample/core/services/service_locator.dart';
import 'package:zample/core/services/shared_preferences_service.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemeMode.light));

  Future<void> switchTheme() async {
    final bool lightTheme = state.mode == ThemeMode.light;
    emit(ThemeState(lightTheme ? ThemeMode.dark : ThemeMode.light));
    await app.get<SharedPreferencesService>().setIsLightTheme(
          lightTheme: lightTheme,
        );
  }

  Future<void> initialize() async {
    final bool lightTheme =
        await app.get<SharedPreferencesService>().isLightTheme();
    emit(ThemeState(lightTheme ? ThemeMode.dark : ThemeMode.light));
  }
}
