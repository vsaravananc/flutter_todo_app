import 'package:in_app_update/in_app_update.dart';

abstract final class AppUpdate {
  static Future<AppUpdateInfo> _checkForUpdate() async =>
      await InAppUpdate.checkForUpdate();
  static Future<void> _performImmediateUpdate() async =>
      await InAppUpdate.performImmediateUpdate();
  static Future<void> _startFlexibleUpdate() async =>
      await InAppUpdate.startFlexibleUpdate();
  static Future<void> _completeFlexibleUpdate() async =>
      await InAppUpdate.completeFlexibleUpdate();

  static Future<void> checkAndUpdate() async {
    final updateInfo = await _checkForUpdate();
    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable ||
        updateInfo.updateAvailability ==
            UpdateAvailability.developerTriggeredUpdateInProgress) {
      if (updateInfo.immediateUpdateAllowed) {
        await _performImmediateUpdate();
      } else if (updateInfo.flexibleUpdateAllowed) {
        await _startFlexibleUpdate();
        await _completeFlexibleUpdate();
      }
    }
  }
}
