import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/themes/app_colors.dart';
import 'package:projeto_controle_financeiro/themes/app_typograph.dart';

const double borderRadiusValue = 8.0;
final borderRadiusCircular = BorderRadius.circular(borderRadiusValue);
const borderRadiusAll = BorderRadius.all(Radius.circular(borderRadiusValue));

final elevatedButtonStyle = ElevatedButton.styleFrom(
    primary: AppColors.primaryColor,
    onPrimary: AppColors.textColor,
    textStyle: AppTypograph.buttonText,
    shape: RoundedRectangleBorder(borderRadius: borderRadiusCircular));

final outlinedButtonStyle = OutlinedButton.styleFrom(
    primary: AppColors.textColor,
    textStyle: AppTypograph.buttonText,
    shape: RoundedRectangleBorder(borderRadius: borderRadiusCircular),
    side: const BorderSide(
      color: AppColors.primaryColor,
    ));

final textButtonStyle = TextButton.styleFrom(
    primary: AppColors.primaryColor, textStyle: AppTypograph.buttonText);

final inputDecorationTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    hintStyle: AppTypograph.hintText,
    labelStyle: AppTypograph.labelText,
    filled: true,
    fillColor: const Color.fromRGBO(31, 170, 0, 0.1),
    border: const OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: borderRadiusAll),
    alignLabelWithHint: true,
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: borderRadiusAll),
    errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.informationErrorColor),
        borderRadius: borderRadiusAll));

const iconThemeData = IconThemeData(color: AppColors.textColor, size: 30);

class AppTheme {
  static ThemeData get light {
    return ThemeData(
        scaffoldBackgroundColor: AppColors.secondaryColor,
        iconTheme: iconThemeData,
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: elevatedButtonStyle),
        outlinedButtonTheme:
            OutlinedButtonThemeData(style: outlinedButtonStyle),
        textButtonTheme: TextButtonThemeData(style: textButtonStyle),
        inputDecorationTheme: inputDecorationTheme,
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.secondaryColor,
            iconTheme: iconThemeData,
            elevation: 0,
            titleTextStyle: AppTypograph.headline5));
  }
}
