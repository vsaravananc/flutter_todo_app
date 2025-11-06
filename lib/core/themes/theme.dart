import 'package:flutter/material.dart';
import 'package:todoapp/core/themes/colors.dart';
import 'package:todoapp/core/themes/text_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: LightColors.primaryColor,
    scaffoldBackgroundColor: LightColors.backgroundColor,
    colorScheme: ColorScheme.light(
      primary: LightColors.primaryColor,
      secondary: LightColors.secondaryColor,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: LightColors.backgroundColor,
      iconTheme: IconThemeData(color: LightColors.primaryColor),
      titleTextStyle: TextStyle(
        color: LightColors.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      elevation: 0,
    ),

    textTheme: CustomTextTheme.baseTextTheme.apply(
      bodyColor: LightColors.textColor,
      displayColor: LightColors.textColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: DarkColors.primaryColor,
    scaffoldBackgroundColor: DarkColors.backgroundColor,
    colorScheme: ColorScheme.dark(
      primary: DarkColors.primaryColor,
      secondary: DarkColors.secondaryColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: DarkColors.backgroundColor,
      iconTheme: IconThemeData(color: DarkColors.primaryColor),
      titleTextStyle: TextStyle(
        color: DarkColors.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      elevation: 0,
    ),
    textTheme: CustomTextTheme.baseTextTheme.apply(
      bodyColor: DarkColors.textColor,
      displayColor: DarkColors.textColor,
    ),
  );
}
