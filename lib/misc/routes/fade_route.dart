import 'package:flutter/material.dart';

/// A [PageRoute] that fades into the new widget.
class FadeRoute<T> extends PageRoute<T> {
  FadeRoute({
    this.builder,
    RouteSettings settings,
    this.duration = const Duration(milliseconds: 1200),
  }) : super(settings: settings);

  final WidgetBuilder builder;
  final Duration duration;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    );
  }
}
