import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zample/components/landing/bloc/cubit/social_links_cubit.dart';
import 'package:zample/components/landing/ui/widgets/social_links.dart';
import 'package:zample/gen/assets.gen.dart';

/// Die LandingPage dient zur Authentifizierung
/// des Users.
class LandingPage extends StatelessWidget {
  static const String route = 'landing_page';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.background.path),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                              left: size.width * 0.1,
                              right: size.width * 0.1,
                              top: size.height * 0.15,
                              bottom: size.height * 0.02,
                            ),
                            alignment: Alignment.topCenter,
                            child: Assets.images.zample
                                .image(height: 120, width: 120)),
                        Text(
                          "Welcome to Zample",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          "Choose a login Option",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: size.height * 0.18),
                        BlocProvider<SocialLinksCubit>(
                          create: (_) => SocialLinksCubit(),
                          child: SocialLinks(),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
