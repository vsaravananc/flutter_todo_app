import 'package:flutter/material.dart';
import 'package:todoapp/core/themes/colors.dart';
import 'package:todoapp/core/themes/text_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: LightColors.primaryColor,
    scaffoldBackgroundColor: LightColors.backgroundColor,
    colorScheme: ColorScheme.light(
      primary: LightColors.primaryColor,
      secondary: LightColors.secondaryColor,
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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: LightColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    textTheme: CustomTextTheme.lightTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: DarkColors.primaryColor,
    scaffoldBackgroundColor: DarkColors.backgroundColor,
    colorScheme: ColorScheme.dark(
      primary: DarkColors.primaryColor,
      secondary: DarkColors.secondaryColor,
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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: DarkColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    textTheme: CustomTextTheme.darkTheme,
  );
}
