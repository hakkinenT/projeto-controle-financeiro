// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../themes/themes.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final String? helperText;
  final String? errorText;
  TextAlign textAlign;
  bool autofocus;
  bool readOnly;
  bool? showCursor;
  bool obscureText;

  CustomTextFormField(
      {Key? key,
      required this.labelText,
      this.hintText,
      this.controller,
      this.initialValue,
      this.focusNode,
      this.decoration,
      this.keyboardType,
      this.textInputAction,
      this.style,
      this.onChanged,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.onTap,
      this.validator,
      this.prefixIcon,
      this.helperText,
      this.errorText,
      this.textAlign = TextAlign.start,
      this.autofocus = false,
      this.readOnly = false,
      this.showCursor,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: initialValue,
      autofocus: autofocus,
      decoration: InputDecoration(
          hintText: hintText,
          label: Text(
            labelText,
            style: AppTypograph.labelText,
          ),
          prefixIcon: prefixIcon,
          helperText: helperText,
          errorText: errorText),
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: style,
      textAlign: textAlign,
      readOnly: readOnly,
      showCursor: showCursor,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      validator: validator,
    );
  }
}
