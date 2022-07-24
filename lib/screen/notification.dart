// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class Notification extends StatefulWidget {
//   const Notification({Key? key}) : super(key: key);

//   @override
//   _NotificationState createState() => _NotificationState();
// }

// class _NotificationState extends State<Notification> {
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   @override
//   void initState() {
//     super.initState();
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     var android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initSettings = InitializationSettings(android: android);
//     flutterLocalNotificationsPlugin.initialize(initSettings,
//         onSelectNotification: onSelectNotification());
//   }

//   Future onSelectNotification(String payload) {
//     debugPrint("payload : $payload");
//     return showDialog(
//         context: context,
//         builder: (_) {
//           return new AlertDialog(
//             title: new Text('Notification'),
//             content: new Text('$payload'),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
