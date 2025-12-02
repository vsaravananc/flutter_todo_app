import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

abstract class DeviceInfo {
  Future<bool> get isAndroid11;
}

class DeviceInfoImpl implements DeviceInfo {
  final DeviceInfoPlugin _deviceInfo;
  static DeviceInfoImpl? _instance;

  DeviceInfoImpl._(this._deviceInfo);

  factory DeviceInfoImpl.init({required DeviceInfoPlugin deviceInfoPlugin}) {
    return _instance ??= DeviceInfoImpl._(deviceInfoPlugin);
  }

  @override
  Future<bool> get isAndroid11 async => await _getInfo();

  Future<bool> _getInfo() async {
    AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
    return androidInfo.version.sdkInt < 31;
  }

}

class DeviceProvider extends InheritedNotifier<ValueNotifier<bool>> {
  const DeviceProvider({
    super.key,
    required super.child,
    required super.notifier,
  });

  static bool of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<DeviceProvider>();
    return provider?.notifier?.value ?? true;
  }
}
