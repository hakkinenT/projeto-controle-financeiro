import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonLabel;
  final double width;
  final double height;
  final Function()? onPressed;
  const CustomElevatedButton(
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
      child: ElevatedButton(
        child: Text(buttonLabel),
        onPressed: onPressed,
      ),
    );
  }
}
