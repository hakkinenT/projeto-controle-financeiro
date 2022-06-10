// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../themes/themes.dart';

class CustomDropDownButton extends StatelessWidget {
  final String hintText;
  final String? initialValue;
  final FocusNode? focusNode;
  final Function(String?)? onChanged;
  final List<String> items;
  final double width;
  final double height;
  final Widget? prefixIcon;
  bool enabled;

  CustomDropDownButton(
      {Key? key,
      required this.hintText,
      this.initialValue,
      this.focusNode,
      required this.items,
      required this.onChanged,
      required this.width,
      required this.height,
      this.prefixIcon,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
          ),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ));
          }).toList(),
          hint: Text(
            hintText,
            style: AppTypograph.labelText.copyWith(fontSize: 16),
          ),
          onChanged: enabled ? onChanged : null,
          disabledHint: enabled
              ? null
              : Text(initialValue!, style: AppTypograph.smallText),
          value: initialValue,
          icon: const Icon(
            Icons.expand_more,
            color: AppColors.primaryDarkColor,
          ),
          style: AppTypograph.hintText.copyWith(color: AppColors.textColor),
          focusNode: focusNode,
        ),
      ),
    );
  }
}
