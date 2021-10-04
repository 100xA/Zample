import 'package:flutter/material.dart';
import 'package:zample/misc/theme/colors.dart';

class ZampBackButton extends StatelessWidget {
  const ZampBackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(
        Icons.chevron_left_rounded,
        color: yellowColor,
      ),
    );
  }
}
