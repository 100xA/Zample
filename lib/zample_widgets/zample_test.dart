import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zample/components/landing/bloc/cubit/social_links_cubit.dart';

class ZampleTest extends StatelessWidget {
  static const String route = 'zample_test';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocialLinksCubit>(
      create: (_) => SocialLinksCubit(),
      child: Container(child: Text("Jan")),
    );
  }
}
