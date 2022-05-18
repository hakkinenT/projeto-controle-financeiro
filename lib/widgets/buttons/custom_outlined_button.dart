import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String buttonLabel;
  final double height;
  final double width;
  final Function()? onPressed;
  const CustomOutlinedButton(
      {Key? key,
      required this.buttonLabel,
      required this.onPressed,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        child: Text(buttonLabel),
        onPressed: onPressed,
      ),
    );
  }
}
