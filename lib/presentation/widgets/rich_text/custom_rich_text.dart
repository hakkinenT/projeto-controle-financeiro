import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../themes/themes.dart';

class CustomRichText extends StatelessWidget {
  final String text;
  final String clickableText;
  final Function()? onTap;
  const CustomRichText(
      {Key? key,
      required this.text,
      required this.clickableText,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RichText(
            text:
                TextSpan(text: text, style: AppTypograph.smallText, children: [
      TextSpan(
          text: clickableText,
          style: AppTypograph.smallTextBold
              .copyWith(color: AppColors.primaryDarkColor),
          recognizer: TapGestureRecognizer()..onTap = onTap)
    ])));
  }
}
