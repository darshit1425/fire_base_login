import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static NotificationHelper Helper = NotificationHelper._();

  NotificationHelper._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

//////////////////////////////////////////////////////////////////////////
  NotificationDetails get notificationDetails => NotificationDetails();

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

  Future<void> showSimpleNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", "ANDROID");
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.show(
        1, "Darshit app", "Simple Notification", notificationDetails);
  }

  Future<void> showScheduleNotification() async {
    AndroidNotificationDetails andriod =
        const AndroidNotificationDetails("1", "flutter");

    DarwinNotificationDetails ioSDetails = const DarwinNotificationDetails();

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "Flutter darshit",
        "5 sec",
        tz.TZDateTime.now(tz.local).add(Duration(days: 2)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> ShowCustomNotification() async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
        "1", "FLUTTER",
        sound: RawResourceAndroidNotificationSound('music'),playSound: true);

    DarwinNotificationDetails ioSDetails = DarwinNotificationDetails();
    NotificationDetails notificationDetails =
        NotificationDetails(iOS: ioSDetails, android: android);

    await flutterLocalNotificationsPlugin.show(
        1, "Flutter Notification", "simple notification", notificationDetails);
  }
}
