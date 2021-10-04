import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:zample/components/profile/bloc/cubit/profile_cubit.dart';
import 'package:zample/core/bloc/auth/cubit/auth_cubit.dart';
import 'package:zample/core/services/service_locator.dart';
import 'package:zample/misc/theme/colors.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {Navigator.of(context).pop()},
          iconSize: 30,
          icon: const Icon(Icons.chevron_left_sharp, color: yellowColor),
        ),
        title: Text(
          "Einstellungen",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Allgemeines",
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => app<AuthCubit>().logOutRequested(),
                child: Text(
                  "Logout",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Bist du dir sicher, dass du deinen Account löschen willst?',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    // ignore: avoid_redundant_argument_values
                    duration: const Duration(seconds: 4),
                    backgroundColor: yellowColor,
                    action: SnackBarAction(
                      label: 'Ja',
                      onPressed: () {
                        app<ProfileCubit>().deleteAcc();
                      },
                      textColor: Theme.of(context).textTheme.headline3.color,
                    ),
                  ),
                ),
                child: Text(
                  "Account löschen",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              const SizedBox(height: 25),
              Divider(color: Theme.of(context).primaryColor),
              const SizedBox(height: 25),
              Text(
                "Links",
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async => await canLaunch(
                  "https://www.notion.so/Rechtliches-3a5c4405a235440f9f37316195fa0559",
                )
                    ? await launch(
                        "https://www.notion.so/Rechtliches-3a5c4405a235440f9f37316195fa0559",
                      )
                    : throw 'Der Link funktioniert nicht',
                child: Text(
                  "Rechtliches",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {},
                child: Text(
                  "Datenschutz",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {},
                child: Text(
                  "Impressum",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {},
                child: Text(
                  "Über uns",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              const SizedBox(height: 25),
              Divider(color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
