import 'package:flutter/material.dart';
import 'package:zample/misc/theme/colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: redColor,
  highlightColor: redColor,
  backgroundColor: Colors.white,
  bottomNavigationBarTheme: ThemeData.light().bottomNavigationBarTheme.copyWith(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black26,
        showUnselectedLabels: false,
      ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: redColor,
  highlightColor: redColor,
  bottomNavigationBarTheme: ThemeData.dark().bottomNavigationBarTheme.copyWith(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white24,
        showUnselectedLabels: false,
      ),
);
