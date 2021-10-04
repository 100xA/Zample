import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zample/components/profile/bloc/cubit/profile_cubit.dart';
import 'package:zample/components/profile/bloc/cubit/profile_state.dart';
import 'package:zample/components/profile/ui/widgets/custom_avatar.dart';
import 'package:zample/components/settings/settings_screen.dart';

import 'package:zample/core/services/service_locator.dart';
import 'package:zample/misc/theme/colors.dart';

class ProfileScreen extends StatelessWidget {
  static const route = "profile_screen";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool show = false;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.profile?.description == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background_profile.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: size.width * 0.02,
                    top: size.height * 0.02,
                    child: IconButton(
                      onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        ),
                      },
                      iconSize: 30,
                      icon: const Icon(Icons.settings, color: darkGreyColor),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.125,
                    left: size.width * 0.04,
                    child: Container(
                      width: size.width * 0.925,
                      height: 260,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10.0, //color of shadow
                            spreadRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: size.width * 0.3,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: size.height * 0.02),
                                  Text(
                                    state.profile?.username ?? "Ladet...",
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  SizedBox(height: size.height * 0.04),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "0",
                                            style: Theme.of(context)
                                                .textTheme
                                                .button,
                                          ),
                                          Text(
                                            "Ideas",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: size.width * 0.075),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "0",
                                            style: Theme.of(context)
                                                .textTheme
                                                .button,
                                          ),
                                          Text(
                                            "% positive",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: size.width * 0.075),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Assists",
                                            style: Theme.of(context)
                                                .textTheme
                                                .button,
                                          ),
                                          Text(
                                            "Assists",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              buildCounter: (
                                BuildContext context, {
                                int currentLength,
                                int maxLength,
                                bool isFocused,
                              }) {
                                if (show) {
                                  return Text(
                                    '$currentLength/$maxLength',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color,
                                    ),
                                  );
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText2.color,
                              ),
                              initialValue: state.profile?.description,
                              onChanged: (value) {
                                show = true;
                                app
                                    .get<ProfileCubit>()
                                    .updateDescription(value);
                              },
                              onFieldSubmitted: (value) {
                                show = false;
                                app.get<ProfileCubit>().writeNewDescription();
                              },
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              maxLength: 100,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintMaxLines: 3,
                                hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .color,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.all(size.width * 0.05),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.075,
                    left: size.width * 0.04,
                    child: CustomAvatar(
                      imageUrl: state.profile?.avatarUrl,
                      size: size,
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.475,
                    left: size.width * 0.04,
                    child: Text(
                      "Ideas",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
