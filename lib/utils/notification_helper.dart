import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static NotificationHelper Helper = NotificationHelper._();

  NotificationHelper._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('notification');

    final DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidSettings, iOS: iosSettings, macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showSimpleNotification()  async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", "ANDROID");
    DarwinNotificationDetails iosDetails =
        DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.show(
        1, "Darshit app", "Simple Notification", notificationDetails);
  }

  void showScheduleNotification() {}
}
