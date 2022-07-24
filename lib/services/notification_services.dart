import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  static final NotificationServices _notificationServices =
      NotificationServices._internal();
  factory NotificationServices() {
    return _notificationServices;
  }
  NotificationServices._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
}
