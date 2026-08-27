import 'package:flutter/services.dart';

abstract final class HappticEffect {
  static Future<void> mediumEffect() async => HapticFeedback.mediumImpact();
  static Future<void> selectionEffect() async =>
      HapticFeedback.selectionClick();
  static Future<void> successEffect() async =>
      HapticFeedback.successNotification();
}
