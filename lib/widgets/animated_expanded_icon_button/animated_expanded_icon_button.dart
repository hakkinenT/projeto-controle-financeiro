import 'package:flutter/material.dart';

class AnimatedExpandIconButton extends StatefulWidget {
  const AnimatedExpandIconButton({Key? key}) : super(key: key);

  @override
  State<AnimatedExpandIconButton> createState() =>
      _AnimatedExpandIconButtonState();
}

class _AnimatedExpandIconButtonState extends State<AnimatedExpandIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        upperBound: 0.5);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: IconButton(
          onPressed: () {
            setState(() {
              if (isExpanded) {
                controller.reverse(from: 0.5);
              } else {
                controller.forward(from: 0.0);
              }

              isExpanded = !isExpanded;
            });
          },
          icon: const Icon(Icons.expand_less)),
    );
  }
}
