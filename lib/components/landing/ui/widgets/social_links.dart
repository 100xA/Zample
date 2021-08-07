import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zample/components/landing/bloc/cubit/social_links_cubit.dart';
import 'package:zample/components/landing/bloc/cubit/social_links_state.dart';
import 'package:zample/misc/theme/colors.dart';

class SocialLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<SocialLinksCubit, SocialLinksState>(
      listener: (context, state) {
        if (state.error.trim().isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => context.read<SocialLinksCubit>().logInWithGoogle(),
              child: Image.asset(
                "assets/images/google.png",
                height: 60,
                width: 60,
              ),
            ),
            SizedBox(
              height: size.height * 0.225,
            ),
            InkWell(
              onTap: () => context.read<SocialLinksCubit>().noLogin(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Or continue without a profile",
                      style: Theme.of(context).textTheme.headline6),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: yellowColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
