import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zample/components/home/bloc/cubit/home_cubit.dart';
import 'package:zample/components/home/bloc/cubit/home_state.dart';
import 'package:zample/components/profile/bloc/cubit/profile_cubit.dart';
import 'package:zample/components/profile/ui/profile_screen.dart';
import 'package:zample/core/services/service_locator.dart';
import 'package:zample/misc/theme/colors.dart';
import 'package:zample/misc/widgets/zample_bottom_navy_bar.dart';

class HomeScreen extends StatelessWidget {
  static const String route = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Scaffold(
        body: _buildBody(state),
        bottomNavigationBar: ZampleBottomNavyBar(
          curve: Curves.easeIn,
          backgroundColor: Theme.of(context).highlightColor,
          selectedIndex: state.index,
          containerHeight: size.height * 0.08,
          onItemSelected: (value) =>
              context.read<HomeCubit>().switchToTab(value),
          items: [
            ZampleBottomNavyBarItem(
              title: Text("Home", style: Theme.of(context).textTheme.button),
              activeColor: Theme.of(context).backgroundColor,
              icon: state.index == 0
                  ? const Icon(
                      Icons.home,
                      color: yellowColor,
                    )
                  : const Icon(Icons.home),
            ),
            ZampleBottomNavyBarItem(
              title: Text("Chat", style: Theme.of(context).textTheme.button),
              activeColor: Theme.of(context).backgroundColor,
              icon: state.index == 1
                  ? const Icon(
                      Icons.chat_bubble,
                      color: yellowColor,
                    )
                  : const Icon(Icons.chat_bubble),
            ),
            ZampleBottomNavyBarItem(
              activeColor: Theme.of(context).backgroundColor,
              icon: state.index == 2
                  ? const Icon(
                      Icons.star,
                      color: yellowColor,
                    )
                  : const Icon(Icons.star),
              title: Text("Star", style: Theme.of(context).textTheme.button),
            ),
            ZampleBottomNavyBarItem(
              activeColor: Theme.of(context).backgroundColor,
              icon: state.index == 3
                  ? const Icon(
                      Icons.person,
                      color: yellowColor,
                    )
                  : const Icon(Icons.person),
              title: Text("Profile", style: Theme.of(context).textTheme.button),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(HomeState state) {
    switch (state.index) {
      case 0:
        return const Center(
          child: Text("Home"),
        );
      case 1:
        return const Center(
          child: Text("Chat"),
        );
      case 2:
        return const Center(
          child: Text("Challenge"),
        );
      case 3:
        return BlocProvider<ProfileCubit>.value(
          value: app.get<ProfileCubit>()..initialize(),
          child: ProfileScreen(),
        );

      default:
        return const Center(
          // ignore: require_trailing_commas
          child: Text(
            "Es scheint ein Problem mit der App zu geben, starte bitte die App neu",
          ),
        );
    }
  }
}
