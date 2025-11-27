import 'package:permission_handler/permission_handler.dart';

///
/// THIS CLASS FOR MANAGING NOTIFICATION PERMISSION
///

class NotificationPermission {
  static Future<bool> askPermission() async {
    final bool isGranted = await Permission.notification.isGranted;
    if (!isGranted) {
      final PermissionStatus isRequested = await Permission.notification
          .request();
      return isRequested.isGranted;
    }
    return isGranted;
  }
}
