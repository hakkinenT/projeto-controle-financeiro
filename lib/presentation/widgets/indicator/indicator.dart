import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final bool isSquare;
  final double size;

  const Indicator({
    Key? key,
    required this.color,
    required this.isSquare,
    this.size = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
      ],
    );
  }
}
