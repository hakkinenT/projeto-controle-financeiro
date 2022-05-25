import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class GoogleButton extends StatelessWidget {
  final double width;
  final double height;
  final Function()? onTap;
  const GoogleButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/google-icon.png'),
          const SizedBox(
            width: 12,
          ),
          Text(
            'Continue com o Google',
            style: AppTypograph.buttonText,
          )
        ]),
      ),
    );
  }
}
