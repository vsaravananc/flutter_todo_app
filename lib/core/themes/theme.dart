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
      surface: LightColors.secondaryBackgroundColor,
      brightness: Brightness.light,
    ),

    textTheme: CustomTextTheme.baseTextTheme.apply(
      bodyColor: LightColors.textColor,
      displayColor: LightColors.textColor,
    ),

    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      side: BorderSide.none,
      showCheckmark: false,
      selectedColor: LightColors.primaryColor,
      backgroundColor: LightColors.secondaryColor,
      brightness: Brightness.dark,
      selectedShadowColor: LightColors.primaryColor,
      labelStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
        color: LightColors.textColor,
      ),
      surfaceTintColor: LightColors.textColor,
      secondaryLabelStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
        color: LightColors.textColor,
      ),
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
      surface: DarkColors.secondaryBackgroundColor,
      brightness: Brightness.dark,
    ),

    textTheme: CustomTextTheme.baseTextTheme.apply(
      bodyColor: DarkColors.textColor,
      displayColor: DarkColors.textColor,
    ),

    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      side: BorderSide.none,
      showCheckmark: false,
      selectedColor: DarkColors.primaryColor,
      backgroundColor: DarkColors.secondaryColor,
      brightness: Brightness.dark,
      selectedShadowColor: DarkColors.primaryColor,
      labelStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
        color: DarkColors.textColor,
        
      ),
      surfaceTintColor: DarkColors.textColor,
      secondaryLabelStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
        color: DarkColors.textColor,
      ),
    ),
  );
}
