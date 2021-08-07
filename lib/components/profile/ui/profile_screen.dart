import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zample/components/profile/bloc/cubit/profile_cubit.dart';
import 'package:zample/components/profile/bloc/cubit/profile_state.dart';
import 'package:zample/components/profile/ui/widgets/custom_avatar.dart';
import 'package:zample/core/bloc/auth/cubit/auth_cubit.dart';
import 'package:zample/core/services/service_locator.dart';
import 'package:zample/misc/theme/colors.dart';

class ProfileScreen extends StatelessWidget {
  static const route = "profile_screen";
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController descController = new TextEditingController();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background_profile.png"),
              fit: BoxFit.fill),
        ),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state.profile.uid == null) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      "Lade",
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
          builder: (context, state) => SafeArea(
            child: Container(
              child: Stack(
                children: [
                  Positioned(
                    right: size.width * 0.02,
                    top: size.height * 0.02,
                    child: IconButton(
                      onPressed: () => {app.get<AuthCubit>().logOutRequested()},
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
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.35,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: size.height * 0.02),
                                  Text(state.profile?.username ?? "Ladet...",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1),
                                  SizedBox(height: size.height * 0.04),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("0",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button),
                                          Text("Ideas",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2),
                                        ],
                                      ),
                                      SizedBox(width: size.width * 0.075),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("0",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button),
                                          Text("% positive",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2),
                                        ],
                                      ),
                                      SizedBox(width: size.width * 0.075),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Assists",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button),
                                          Text("Assists",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Container(
                              height: size.height * 0.1,
                              padding: EdgeInsets.only(
                                  left: size.width * 0.05,
                                  right: size.width * 0.05),
                              child: GestureDetector(
                                onTap: () {
                                  _displayDialog(context);
                                },
                                child: Text(
                                  state.profile?.description ??
                                      "Kurze Beschreibung",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    child: CustomAvatar(imageUrl: state.profile?.avatarUrl),
                    top: size.height * 0.075,
                    left: size.width * 0.04,
                  ),
                  Positioned(
                    top: size.height * 0.475,
                    left: size.width * 0.04,
                    child: Text("Ideas",
                        style: Theme.of(context).textTheme.headline1),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_displayDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (_) {
        return UserNameEditDialog();
      });
}

class UserNameEditDialog extends StatelessWidget {
  // Pass the user, which name may be changed trough this widget

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: Text(
        'Meine Beschreibung',
        style: TextStyle(fontSize: 18),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Nothing", contentPadding: EdgeInsets.all(0.0)),
              controller: textEditingController,
              validator: (val) =>
                  val.trim().length < 3 || val.trim().length > 18
                      ? 'Bitte gib einen gültigen Benutzernamen ein.'
                      : null,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              //profile.des = textEditingController.text;
              print(textEditingController.text);
              app
                  .get<ProfileCubit>()
                  .writeNewDescription(textEditingController.text);
              Navigator.of(context).pop();

              //await userRepository.updateUser(user: userData);
            }
          },
        )
      ],
    );
  }
}
