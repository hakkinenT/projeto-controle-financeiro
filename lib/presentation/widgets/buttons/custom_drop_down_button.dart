// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../themes/themes.dart';

class CustomDropDownButton extends StatelessWidget {
  final String hintText;
  final String? initialValue;
  final FocusNode? focusNode;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final List<String> items;
  final double width;
  final String? errorText;
  final Widget? prefixIcon;
  final Function()? onTap;
  bool enabled;

  CustomDropDownButton(
      {Key? key,
      required this.hintText,
      this.initialValue,
      this.onTap,
      this.focusNode,
      required this.items,
      required this.onChanged,
      this.validator,
      required this.width,
      this.errorText,
      this.prefixIcon,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: const BoxConstraints(minHeight: 52, maxHeight: 80),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          onTap: onTap,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          decoration:
              InputDecoration(prefixIcon: prefixIcon, errorText: errorText),
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
              : Text(initialValue!,
                  style: AppTypograph.smallText
                      .copyWith(color: AppColors.textColor)),
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
