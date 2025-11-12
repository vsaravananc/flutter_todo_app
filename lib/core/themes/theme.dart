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
      tertiary: LightColors.popMenuColor,
      brightness: Brightness.light,
      error: LightColors.errorColor
    ),

    textTheme: CustomTextTheme.baseTextTheme.apply(
      bodyColor: LightColors.textColor,
      displayColor: LightColors.textColor,
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: LightColors.backgroundColor,
      shadowColor: LightColors.shadowColor,
      elevation: 0.5,
    ),
    checkboxTheme: CheckboxThemeData(
      shape: const CircleBorder(),
      side: BorderSide(
        width: 0.8,
        color: LightColors.textColor,
        style: BorderStyle.solid,
      ),
      splashRadius: 0.4,
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
    shadowColor: DarkColors.shadowColor,
    colorScheme: ColorScheme.dark(
      primary: DarkColors.primaryColor,
      secondary: DarkColors.secondaryColor,
      surface: DarkColors.secondaryBackgroundColor,
      tertiary: DarkColors.popMenuColor,
      brightness: Brightness.dark,
      error: DarkColors.errorColor
    ),

    textTheme: CustomTextTheme.baseTextTheme.apply(
      bodyColor: DarkColors.textColor,
      displayColor: DarkColors.textColor,
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: DarkColors.backgroundColor,
      shadowColor: DarkColors.shadowColor,
      elevation: 0.5,
    ),

    checkboxTheme: CheckboxThemeData(
      shape: const CircleBorder(),
      side: BorderSide(
        width: 0.8,
        color: DarkColors.textColor,
        style: BorderStyle.solid,
      ),
      splashRadius: 0.4,
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
