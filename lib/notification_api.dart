import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static const android = AndroidInitializationSettings("@mipmap/ic_launcher");
  static const ios = IOSInitializationSettings();
  static final _notifications = FlutterLocalNotificationsPlugin();
  static const settings = InitializationSettings(iOS: ios, android: android);
  static final onNotification = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            importance: Importance.max),
        iOS: IOSNotificationDetails());
  }

  static Future init({bool initScheduled = false}) async {
    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotification.add(payload);
    });
  }

  static Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

  static Future showScheduledNotification(
          {int id = 0,
          String? title,
          String? body,
          String? payload,
          required DateTime scheduledTime}) async =>
      _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledTime, tz.local),
          await _notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
}

