import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zample/components/landing/bloc/cubit/social_links_cubit.dart';
import 'package:zample/components/landing/bloc/cubit/social_links_state.dart';

import 'package:zample/misc/theme/colors.dart';

class SocialLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                backgroundColor: redColor,
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
            const SizedBox(height: 250.0),
            const Text(
              "© Zample 2021",
              style: TextStyle(
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? prefix;
  final String? text;

  const LoginButton({
    Key? key,
    this.onPressed,
    this.prefix,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(0),
      color: Colors.white,
      onPressed: onPressed,
      child: Row(
        children: [
          Container(
            height: 50.0,
            width: 90.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 12.0,
            ),
            child: prefix,
          ),
          Text(text!),
        ],
      ),
    );
  }
}
