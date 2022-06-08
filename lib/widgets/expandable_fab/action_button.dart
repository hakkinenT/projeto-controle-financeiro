import 'package:flutter/material.dart';

import '../../themes/themes.dart';

/*@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({Key? key, this.onPressed, required this.icon, this.label})
      : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: label != null ? 115 : 50,
      height: label != null ? 45 : 50,
      child: Material(
        shape: label != null
            ? const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))
            : const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: AppColors.primaryLightColor,
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: [
              IconButton(
                onPressed: onPressed,
                icon: icon,
                iconSize: 25,
              ),
              Text(
                label ?? '',
                style: AppTypograph.caption,
              )
            ],
          ),
        ),
      ),
    );
  }
}*/

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({Key? key, this.onPressed, required this.icon})
      : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryLightColor,
      onPressed: onPressed,
      child: icon,
    );
  }
}
