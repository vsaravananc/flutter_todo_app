import 'package:flutter/material.dart';
import 'package:todoapp/core/themes/font_family.dart';

class CustomTextTheme {
  static TextTheme get baseTextTheme => const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.sfProD,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      fontFamily: FontFamily.sfProD,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: FontFamily.sfPro,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: FontFamily.sfProD,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: FontFamily.sfPro,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: FontFamily.sfPro,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: FontFamily.sfPro,
    ),
    labelLarge: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      fontFamily: FontFamily.sfPro,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: FontFamily.sfPro,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      fontFamily: FontFamily.sfPro,
    ),
  );
}
