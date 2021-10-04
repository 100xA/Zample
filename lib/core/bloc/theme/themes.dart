import 'package:flutter/material.dart';
import 'package:zample/misc/theme/colors.dart';

ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 25.0,
      color: yellowColor,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 25.0,
      color: lightGreyColor,
    ),
    headline6: TextStyle(
      fontSize: 15.0,
      color: lightGreyColor,
    ),
    bodyText1: TextStyle(
      fontSize: 12.0,
      color: yellowColor,
    ),
    bodyText2: TextStyle(
      fontSize: 10.0,
      color: lightGreyColor,
    ),
    button: TextStyle(
      fontSize: 15.0,
      color: yellowColor,
    ),
  ),
  primaryColor: lightGreyColor,
  highlightColor: yellowColor,
  backgroundColor: darkGreyColor,
  bottomNavigationBarTheme: ThemeData.light().bottomNavigationBarTheme.copyWith(
        selectedItemColor: yellowColor,
        unselectedItemColor: darkGreyColor,
        showUnselectedLabels: false,
      ),
);
