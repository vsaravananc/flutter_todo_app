import 'package:flutter/material.dart';
import 'package:todoapp/main.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routed = {
    "/": (context) => const SplashScreen(),
  };
}
