import 'package:flutter/material.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Widget? avatar;
  final Function(bool)? onSelected;
  const CustomFilterChip({
    Key? key,
    required this.label,
    this.selected = false,
    this.avatar,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
        label: Text(
          label,
        ),
        selected: selected,
        showCheckmark: false,
        avatar: avatar,
        padding: const EdgeInsets.only(left: 10, right: 10),
        labelPadding:
            const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
        onSelected: onSelected);
  }
}
