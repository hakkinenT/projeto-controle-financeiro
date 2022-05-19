import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_controle_financeiro/themes/app_colors.dart';

class AppTypograph {
  static final headline3 = GoogleFonts.notoSans(
      textStyle: const TextStyle(
          fontSize: 32,
          //height: 48,
          color: AppColors.textColor));
  static final headline4 = GoogleFonts.notoSans(
      textStyle: const TextStyle(
          fontSize: 26,
          //height: 39,
          color: AppColors.textColor));
  static final headline5 = GoogleFonts.notoSans(
      textStyle: const TextStyle(
          fontSize: 22,
          //height: 33,
          color: AppColors.textColor));
  static final headline6 = GoogleFonts.notoSans(
      textStyle: const TextStyle(
          fontSize: 18,
          //height: 27,
          color: AppColors.textColor));
  static final paragraph = GoogleFonts.notoSans(
      textStyle: const TextStyle(
          fontSize: 32,
          //height: 28.8,
          letterSpacing: 0.5,
          color: AppColors.textColor));
  static final paragraphBold = GoogleFonts.notoSans(
      textStyle: const TextStyle(
          fontSize: 32,
          //height: 28.8,
          letterSpacing: 0.5,
          color: AppColors.textColor,
          fontWeight: FontWeight.w600));
  static final smallText = GoogleFonts.notoSans(
      textStyle: const TextStyle(
          //height: 19.6,
          letterSpacing: 0.25,
          color: AppColors.textColor));
  static final smallTextBold = GoogleFonts.notoSans(
      textStyle: const TextStyle(
          //height: 19.6,
          letterSpacing: 0.25,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor));
  static final hintText = GoogleFonts.notoSans();
  static final labelText = GoogleFonts.notoSans(
      textStyle: const TextStyle(color: AppColors.primaryDarkColor));
  static final buttonText = GoogleFonts.notoSans(
      textStyle: const TextStyle(
          fontSize: 16,
          letterSpacing: 1.25,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor));
  static final caption = GoogleFonts.notoSans(
      textStyle: const TextStyle(fontSize: 12, color: AppColors.textColor));
  static final captionBold = GoogleFonts.notoSans(
      textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textColor));
}
