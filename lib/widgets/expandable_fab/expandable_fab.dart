import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExpandableFab extends StatefulWidget {
  const ExpandableFab(
      {Key? key, required this.children, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _buttonAnimatedIcon;
  late final Animation<double> _translateButton;

  bool _isExpanded = false;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(listen);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addListener(() {
        setState(() {});
      });
    _buttonAnimatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _translateButton = Tween<double>(
      begin: 100,
      end: -20,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.scrollController.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = widget.scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  void _toggle() {
    setState(() {
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
      _isExpanded = !_isExpanded;
    });
  }

  List<Widget> _transformWidget() {
    final transformWidgets = <Widget>[];
    int distance = widget.children.length + 1;
    for (var child in widget.children) {
      final widget = Transform(
        transform: Matrix4.translationValues(
            0.0, _translateButton.value * distance, 0.0),
        child: child,
      );
      distance--;
      transformWidgets.add(widget);
    }
    return transformWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ..._transformWidget(),
        if (isVisible)
          FloatingActionButton(
            onPressed: _toggle,
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _buttonAnimatedIcon,
            ),
          )
      ],
    );
  }
}
