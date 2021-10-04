import 'package:flutter/material.dart';
import 'package:zample/misc/theme/colors.dart';

class ZampSnackBar {
  /// Shows a yellow [SnackBar] for the specified [Scaffold] in the provided
  /// [context] with a [message] and a optional [action].
  static void showErrorSnackBar(
    BuildContext context,
    String message, [
    SnackBarAction action,
  ]) {
    _showSnackBar(context, yellowColor, message, action);
  }

  /// Shows a darkGrey [SnackBar] for the specified [Scaffold] in the provided
  /// [context] with a [message] and a optional [action].
  static void showInfoSnackBar(
    BuildContext context,
    String message, [
    SnackBarAction action,
  ]) {
    _showSnackBar(context, darkGreyColor, message, action);
  }

  static void _showSnackBar(
    BuildContext context,
    Color color,
    String message,
    SnackBarAction action,
  ) {
    // clear all currently open snacknars
    ScaffoldMessenger.of(context).clearSnackBars();
    // show a new snackbar
    ScaffoldMessenger.of(context)
      ..showSnackBar(
        SnackBar(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(),
          duration: const Duration(seconds: 4),
          action: action,
          content: Text(
            message,
            style: const TextStyle(
              color: darkGreyColor,
            ),
          ),
        ),
      );
  }
}
