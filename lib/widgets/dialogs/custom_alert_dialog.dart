import 'package:flutter/material.dart';

import '../../themes/themes.dart';

AlertDialog customAlertDialog(
    {required BuildContext context,
    required String title,
    required String message,
    required IconData informationIcon,
    required Color informationColor,
    List<Widget>? actions}) {
  return AlertDialog(
    title: Row(
      children: [
        Icon(
          informationIcon,
          color: informationColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: AppTypograph.smallTextBold,
        )
      ],
    ),
    titlePadding: const EdgeInsets.only(top: 20, right: 20, left: 20),
    content: Text(
      message,
      style: AppTypograph.smallText.copyWith(color: Colors.black54),
    ),
    contentPadding: const EdgeInsets.all(20),
    actions: actions,
  );
}
