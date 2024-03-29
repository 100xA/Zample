import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
            LoginOptions(),
            SizedBox(
              height: 90,
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

class LoginOptions extends StatefulWidget {
  @override
  _LoginOptionsState createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  final List<String> imgList = [
    "assets/images/google.png",
    "assets/images/facebook.png",
  ];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: [
            InkWell(
              onTap: () => context.read<SocialLinksCubit>().logInWithGoogle(),
              child: Image.asset(
                imgList[0],
                height: 60,
                width: 60,
              ),
            ),
            InkWell(
              onTap: () => context.read<SocialLinksCubit>().logInWithFacebook(),
              child: Image.asset(
                imgList[1],
                height: 65,
                width: 65,
              ),
            ),
          ],
          options: CarouselOptions(
              height: 100,
              initialPage: 0,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.yellow)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
