import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zample/core/error_handler/zample_error_handler.dart';
import 'package:zample/zample_test.dart';
import 'core/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setupServices();
  ZampleErrorHandler(child: ZampleTest());
}
