import 'dart:async';

import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:zample/core/logger/logger_mixin.dart';

class ZampleErrorHandler with ZampleLogger {
  ZampleErrorHandler({
    Widget child,
  }) {
    if (kReleaseMode) {
      // override the error widget in release mode (the red error screen)
      ErrorWidget.builder = (details) => const SizedBox();
    }

    FlutterError.onError = _handleFlutterError;

    runZonedGuarded(
      () async {
        runApp(child);
      },
      _handleError,
    );
  }

  /// Handles errors caught by the Flutter framework.
  ///
  /// Forwards the error to the [_handleError] handler when in release mode.
  /// Prints it to the console otherwise.
  Future<void> _handleFlutterError(FlutterErrorDetails details) async {
    if (kReleaseMode) {
      await FirebaseCrashlytics.instance.recordFlutterError(details);
    } else {
      FlutterError.dumpErrorToConsole(details);
    }
  }

  /// Prints the error and reports it to sentry in release mode.
  Future<void> _handleError(Object error, StackTrace stackTrace) async {
    // report the error in release mode
    if (error is SocketException) {
      return;
    }
    if (kReleaseMode) {
    } else {
      await FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  }
}
