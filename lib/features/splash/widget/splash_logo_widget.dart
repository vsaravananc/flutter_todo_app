import 'package:flutter/material.dart';
import 'package:todoapp/core/images/images.dart';
import 'package:todoapp/core/themes/colors.dart';

///
///  FILE_PURPOSE: SPLASH LOGO
///

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Images.logo,
      height: 20,
      width: 20,
      fit: BoxFit.fill,
      cacheHeight: 40,
      cacheWidth: 40,
      color: Theme.of(context).brightness == Brightness.dark
          ? LightColors.backgroundColor
          : DarkColors.backgroundColor,
    );
  }
}
