import 'package:flutter/material.dart';
import 'package:todoapp/core/pagebuilder/page_route_builder.dart';
import 'package:todoapp/features/home/presentation/home_screen.dart';
import 'package:todoapp/features/splash/presentation/splash_screen.dart';
import 'package:todoapp/features/welcome/presentation/welcome_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String welcomScreen = '/welocome';
  static const String homeScreen = '$welcomScreen/setup';
  static Map<String, Widget Function(BuildContext)> routed = {
    splashScreen: (context) => const SplashScreen(key: Key('splash-screen')),
    welcomScreen: (context) => const WelcomeScreen(key: Key('welcome-screen')),
  };

  static Route? onGenerateRoute(settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return CustomRouteBuilder.simplePageRouteBuilder(const HomeScreen());
      default:
        return null;
    }
  }
}
