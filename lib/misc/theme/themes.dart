import 'package:flutter/material.dart';
import 'package:zample/misc/theme/colors.dart';

ThemeData kTheme = ThemeData(
  primarySwatch: MaterialColor(redColor.value, getSwatch(redColor)),
  bottomNavigationBarTheme: ThemeData.light().bottomNavigationBarTheme.copyWith(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black26,
        showUnselectedLabels: false,
      ),
);

Map<int, Color> getSwatch(Color color) {
  return {
    50: color.withOpacity(.1),
    100: color.withOpacity(.2),
    200: color.withOpacity(.3),
    300: color.withOpacity(.4),
    400: color.withOpacity(.5),
    500: color.withOpacity(.6),
    600: color.withOpacity(.7),
    700: color.withOpacity(.8),
    800: color.withOpacity(.9),
    900: color.withOpacity(1),
  };
}
