import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPermission {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  static late AndroidNotificationDetails _androidNotificationDetails;
  static late AndroidNotificationChannel _androidNotificationChannel;

  static const String _channelId = "todo_channel_id";
  static const String _channelName = "todo_channel_name";

  static void initializNotification() {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initialization = InitializationSettings(
      android: androidInitializationSettings,
    );

    _plugin.initialize(initialization);

    _androidNotificationChannel = const AndroidNotificationChannel(
      _channelId,
      _channelName,
      importance: Importance.max,
    );

    _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidNotificationChannel);
  }

  static void showNotification({
    int id = 0,
    String title = "Todo Title",
    String body = "Todo body",
  }) {
    _androidNotificationDetails = const AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: Importance.max,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: _androidNotificationDetails,
    );

    _plugin.show(id, title, body, notificationDetails);
  }
}
