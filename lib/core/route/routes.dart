import 'package:flutter/material.dart';
import 'package:todoapp/features/splash/presentation/splash_screen.dart';
import 'package:todoapp/features/welcome/presentation/welcome_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String welcomScreen = '/welocome';
  static Map<String, Widget Function(BuildContext)> routed = {
    splashScreen: (context) => const SplashScreen(key: Key('splash-screen'),),
    welcomScreen: (context) => const WelcomeScreen(key: Key('welcome-screen'),),
  };
}
