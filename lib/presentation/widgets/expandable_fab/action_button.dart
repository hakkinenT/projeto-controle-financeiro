import 'package:flutter/material.dart';

import '../../../themes/themes.dart';

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton(
      {Key? key, this.onPressed, required this.icon, required this.heroTag})
      : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      backgroundColor: AppColors.primaryLightColor,
      onPressed: onPressed,
      child: icon,
    );
  }
}
