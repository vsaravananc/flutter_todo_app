import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tl;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

abstract final class NotificationPermission {
  static const addTaskNotificationChannelNameID = "0001";
  static const addTaskNotificationChannelName = "Add Task Notification";

  static const scheduleNotificationChannelNameID = "0002";
  static const scheduleNotificationChannelName = "Schedule Notification";

  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  static const AndroidNotificationChannel _androidNotificationChannel =
      AndroidNotificationChannel(
        addTaskNotificationChannelNameID,
        addTaskNotificationChannelName,
        importance: Importance.max,
        playSound: true,
      );

  static const AndroidNotificationChannel _scheduleNotificationChannel =
      AndroidNotificationChannel(
        scheduleNotificationChannelNameID,
        scheduleNotificationChannelName,
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
        enableLights: true,
        showBadge: true,
        bypassDnd: true,
      );

  static Future<void> initializeNotification() async {
    if (!(await requestNotification())) return;
    const InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);

    tl.initializeTimeZones();
    final timezone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone.identifier));

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );

    final androidNotification = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    androidNotification?.createNotificationChannel(_androidNotificationChannel);
    androidNotification?.createNotificationChannel(
      _scheduleNotificationChannel,
    );
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    if (!await requestNotification()) return;
    AndroidNotificationDetails androidNotificationDetailsionDetails =
        const AndroidNotificationDetails(
          addTaskNotificationChannelNameID,
          addTaskNotificationChannelName,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetailsionDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduleTime,
  }) async {
    if (!(await requestNotification())) return;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          scheduleNotificationChannelNameID,
          scheduleNotificationChannelName,
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    final scheduledDate = tz.TZDateTime.from(scheduleTime, tz.local);

    try {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    } catch (e) {
      debugPrint("Error scheduling notification: $e");
    }
  }

  static Future<bool> requestNotification() async {
    final permission = await Permission.notification.request();
    return permission.isGranted;
  }
}
