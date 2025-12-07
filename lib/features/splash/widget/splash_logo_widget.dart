import 'package:flutter/material.dart';
import 'package:todoapp/core/images/images.dart';

///
///  FILE_PURPOSE: SPLASH LOGO
///

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(Images.logo, height: 50, width: 50, fit: BoxFit.fill);
  }
}
