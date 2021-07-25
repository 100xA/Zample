// @dart=2.9
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zample/core/error_handler/zample_error_handler.dart';
import 'package:zample/core/widgets/global_bloc_provider.dart';
import 'package:zample/zample.dart';

import 'core/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setupServices();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  ZampleErrorHandler(
      child: GlobalBlocProvider(
    child: Zample(),
  ));
}
