import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:zample/misc/theme/colors.dart';
import 'package:zample/misc/widgets/zamp_back_button.dart';

class ZampAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final String actionText;
  final IconData actionIcon;
  final VoidCallback onAction;

  const ZampAppBar({
    Key key,
    this.actionIcon,
    this.titleText,
    this.actionText,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const ZampBackButton(),
      title: Text(
        titleText,
        style: Theme.of(context).textTheme.headline1.copyWith(
              color: yellowColor,
            ),
      ),
      centerTitle: true,
      actions: [
        if (Platform.isIOS)
          TextButton(
            onPressed: onAction,
            child: Text(
              actionText,
              style: Theme.of(context).textTheme.headline1.copyWith(
                    color: yellowColor,
                  ),
            ),
          )
        else
          IconButton(
            onPressed: onAction,
            icon: Icon(
              actionIcon,
              color: yellowColor,
            ),
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
