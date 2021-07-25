import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zample/core/bloc/app/app_cubit.dart';
import 'package:zample/core/bloc/auth/cubit/auth_cubit.dart';
import 'package:zample/core/bloc/theme/theme_cubit.dart';
import 'package:zample/core/services/service_locator.dart';

class GlobalBlocProvider extends StatelessWidget {
  const GlobalBlocProvider({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>.value(
          value: app.get<AppCubit>()..initializeApp(),
        ),
        BlocProvider<AuthCubit>.value(
          value: app.get<AuthCubit>(),
        ),
        BlocProvider<ThemeCubit>.value(
          value: app.get<ThemeCubit>()..initialize(),
        ),
      ],
      child: child,
    );
  }
}
