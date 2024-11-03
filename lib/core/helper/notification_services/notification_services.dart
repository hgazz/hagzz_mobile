import 'dart:async';

import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

StreamController<Map<String, String>> notificationsStream =
    StreamController<Map<String, String>>.broadcast();

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      AppFunctions.logPrint(message: "My Repomse  e");
    });
  }

  static notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max, icon: "image"),
        iOS: DarwinNotificationDetails());
  }

  static Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  static void display(String title, String message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails('channelId', 'channelName',
              importance: Importance.max, priority: Priority.high));
      await notificationsPlugin.show(id, title, message, notificationDetails);
    } on Exception catch (e) {
      AppFunctions.logPrint(message: "Errrorrrr : ${e.toString()}");
    }
  }

  static void dataAction(RemoteMessage remoteMessage) async {
    String title = '';
    String message = '';
    if (remoteMessage.data['title'] != null) {
      title = remoteMessage.data['title'];
    } else if (remoteMessage.notification?.title != null) {
      title = remoteMessage.notification?.title ?? '';
    }

    if (remoteMessage.data['message'] != null) {
      message = remoteMessage.data['message'];
    } else if (remoteMessage.notification?.body != null) {
      message = remoteMessage.notification?.body ?? '';
    }

    if (title.isNotEmpty && message.isNotEmpty) display(title, message);
  }
}
