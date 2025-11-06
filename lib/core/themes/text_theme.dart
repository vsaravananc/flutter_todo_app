import 'package:flutter/material.dart';

class CustomTextTheme {
  static TextTheme get baseTextTheme => const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans',
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      fontFamily: 'OpenSans',
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: 'OpenSans',
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'OpenSans',
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'OpenSans',
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'OpenSans',
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'OpenSans',
    ),
    labelLarge: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      fontFamily: 'OpenSans',
    ),
      labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: 'OpenSans',
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      fontFamily: 'OpenSans',
    ),
  );
}
