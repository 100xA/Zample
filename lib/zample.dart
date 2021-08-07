import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zample/core/bloc/theme/theme_cubit.dart';
import 'package:zample/core/bloc/theme/theme_state.dart';

import 'package:zample/core/services/navigator_service.dart';

import 'core/bloc/theme/themes.dart';
import 'core/services/service_locator.dart';

class Zample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      return WillPopScope(
        onWillPop: () async => false,
        child: MaterialApp(
          theme: darkTheme,
          debugShowCheckedModeBanner: false,
          navigatorKey: app.get<NavigatorService>().key,
          onGenerateRoute: app.get<NavigatorService>().onGenerateRoute,
          initialRoute: app.get<NavigatorService>().initialRoute,
        ),
      );
    });
  }
}
