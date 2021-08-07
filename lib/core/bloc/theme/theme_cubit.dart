import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:zample/core/bloc/theme/theme_state.dart';
import 'package:zample/core/services/service_locator.dart';
import 'package:zample/core/services/shared_preferences_service.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemeMode.dark));

  Future<void> switchTheme() async {
    final bool darkTheme = state.mode == ThemeMode.dark;
    emit(ThemeState(darkTheme ? ThemeMode.light : ThemeMode.dark));
    await app.get<SharedPreferencesService>().setIsLightTheme(
          lightTheme: darkTheme,
        );
  }

  Future<void> initialize() async {
    final bool darkTheme =
        await app.get<SharedPreferencesService>().isLightTheme();
    emit(ThemeState(darkTheme ? ThemeMode.light : ThemeMode.dark));
  }
}
