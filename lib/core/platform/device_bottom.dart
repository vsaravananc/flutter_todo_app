import 'package:flutter/material.dart';

class DeviceBottom extends InheritedNotifier<ValueNotifier<double>> {
  const DeviceBottom({required super.child,super.key,super.notifier});
  static double of(BuildContext context){
   final provider = context.dependOnInheritedWidgetOfExactType<DeviceBottom>();
   return provider?.notifier?.value ?? 0;
  }
}