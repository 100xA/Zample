import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:zample/components/home/ui/home_screen.dart';

import 'package:zample/components/landing/ui/landing_page.dart';
import 'package:zample/components/profile/ui/profile_screen.dart';
import 'package:zample/core/repo/auth_repository.dart';
import 'package:zample/core/services/service_locator.dart';
import 'package:zample/misc/routes/fade_route.dart';
import 'package:zample/misc/widgets/zample_test.dart';

/// The [RouteType] determines what [PageRoute] is used for the new route.
///
/// This determines the transition animation for the new route.
enum RouteType {
  defaultRoute,
  fade,
}

/// The [NavigatorService] contains the [Navigator] key used by the root
/// [MaterialApp]. This allows for navigation without access to the
/// [BuildContext].
class NavigatorService {
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  final Logger _log = Logger('ZampleNavi');

  /// A [Navigator] observer that is used to notify [RouteAware]s of changes to
  /// the state of their [Route].
  final RouteObserver<PageRoute<dynamic>> routeObserver =
      RouteObserver<PageRoute<dynamic>>();

  NavigatorState get state => key.currentState;
  String initialRoute;

  NavigatorService() {
    initialRoute = app.get<AuthRepository>().getCurrentUser() != null
        ? HomeScreen.route
        : LandingPage.route;
  }

  /// A convenience method to push a new [route] to the [Navigator].
  void pushRoute(Route<void> route) {
    key.currentState.push<void>(route);
  }

  /// A convenience method to push a named replacement route.
  void pushReplacementNamed(
    String route, {
    RouteType type = RouteType.defaultRoute,
    Map<String, dynamic> arguments,
  }) {
    key.currentState
        .pushReplacementNamed<void, void>(route, arguments: <String, dynamic>{
      'routeType': type,
      ...?arguments,
    });
  }

  /// A convenience method to push a named route.
  void pushNamed(
    String route, {
    RouteType type = RouteType.defaultRoute,
    Map<String, dynamic> arguments,
  }) {
    key.currentState.pushNamed<void>(
      route,
      arguments: <String, dynamic>{
        'routeType': type,
      }..addAll(arguments ?? {}),
    );
  }

  void pop([Object result]) {
    key.currentState.pop(result);
  }

  /// [onGenerateRoute] is called whenever a new named route is being pushed to
  /// the app.
  ///
  /// The [RouteSettings.arguments] that can be passed along the named route
  /// needs to be a `Map<String, dynamic>` and can be used to pass along
  /// arguments for the screen.
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;

    final arguments =
        settings.arguments as Map<String, dynamic> ?? <String, dynamic>{};

    final routeType =
        arguments['routeType'] as RouteType ?? RouteType.defaultRoute;
    _log.fine('navigating to $routeName');
    Widget screen;

    switch (routeName) {
      case LandingPage.route:
        _log.fine('navigating to $routeName');
        screen = LandingPage();
        break;
      case ZampleTest.route:
        _log.fine('navigating to $routeName');
        screen = ZampleTest();
        break;
      case HomeScreen.route:
        _log.fine('navigating to $routeName');
        screen = HomeScreen();
        break;
      case ProfileScreen.route:
        _log.fine('navigating to $routeName');
        screen = ProfileScreen();
        break;
      default:
        _log.fine('navigating to $routeName, default Screen');
        screen = HomeScreen();
        break;
    }

    switch (routeType) {
      case RouteType.fade:
        return FadeRoute<void>(
          builder: (_) => screen,
          settings: RouteSettings(name: routeName, arguments: arguments),
        );
      case RouteType.defaultRoute:
      default:
        return CupertinoPageRoute<void>(
          builder: (_) => screen,
          settings: RouteSettings(name: routeName, arguments: arguments),
        );
    }
  }
}
