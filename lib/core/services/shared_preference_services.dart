import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServices {
  final SharedPreferences preferences;

  static SharedPreferenceServices? _instance;
  SharedPreferenceServices._(this.preferences);
  factory SharedPreferenceServices.init({
    required SharedPreferences preferences,
  }) {
    return _instance ??= SharedPreferenceServices._(preferences);
  }

  static SharedPreferenceServices get instance => _instance!;

  Future<void> setValue({required String key, required bool value}) async {
    await preferences.setBool(key, value);
  }

  bool getValue({required String key}){
    return preferences.getBool(key) ?? false;
  }

  bool isLogedIN({required String key}) {
    return preferences.getBool(key) ?? false;
  }
}
