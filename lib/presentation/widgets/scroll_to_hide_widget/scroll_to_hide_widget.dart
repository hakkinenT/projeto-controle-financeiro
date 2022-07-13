import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_controle_financeiro/business_logic/business_logic.dart';

class ScrollToHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const ScrollToHideWidget(
      {Key? key,
      required this.child,
      required this.controller,
      this.duration = const Duration(milliseconds: 200)})
      : super(key: key);

  @override
  State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      context.read<AppInteractionCubit>().showWidgetOnScroll();
    } else if (direction == ScrollDirection.reverse) {
      context.read<AppInteractionCubit>().hideWidgetOnScroll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInteractionCubit, AppInteractionState>(
        builder: (context, state) {
      return AnimatedContainer(
        duration: widget.duration,
        height: state.isPageScroll ? kBottomNavigationBarHeight : 0,
        child: Wrap(children: [widget.child]),
      );
    });
  }
}
