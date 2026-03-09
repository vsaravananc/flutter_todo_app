import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

abstract final class NotificationPermission {
  static const notificationalChannelID = "0001";
  static const notificationChannelName = "Todo_application";

  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  static const AndroidNotificationChannel _androidNotificationChannel =
      AndroidNotificationChannel(
        notificationalChannelID,
        notificationChannelName,
      );

  static Future<void> initializeNotification() async {
    if (!(await requestNotification())) return;
    const InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidNotificationChannel);
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    AndroidNotificationDetails androidNotificationDetailsionDetails =
        const AndroidNotificationDetails(
          notificationalChannelID,
          notificationChannelName,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetailsionDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  static Future<bool> requestNotification() async {
    final permission = await Permission.notification.request();
    return permission.isGranted;
  }
}
