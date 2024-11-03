import 'package:bookit/core/helper/bloc_observer/my_bloc_observer.dart';
import 'package:bookit/core/helper/cach/cached_keys.dart';
import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/hive/hive_helper.dart';
import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/features/session/model/local_model/session_model.dart';
import 'package:bookit/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upgrader/upgrader.dart';

import 'core/app_root/app_root.dart';
import 'core/helper/cach/cach_helper.dart';
import 'core/helper/dio/dio_helper.dart';
import 'core/helper/notification_services/notification_services.dart';
import 'features/session/model/local_model/checkout_model.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Handling a background message: ${message.messageId}");
}

Future<void> cacheStaticUserData() async {
  await CacheHelper.setData(
          key: CachedKeys.token,
          value:
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwaS5oYWd6ei5jb20vYXBpL2xvZ2luIiwiaWF0IjoxNzE0NTYxNzU4LCJleHAiOjE5MzA1NjE3NTgsIm5iZiI6MTcxNDU2MTc1OCwianRpIjoiazVuR01CRFNYeTF6TXZ3WSIsInN1YiI6IjQwIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.rwKMa5yADJWm0m1EMR60dcBVO5yz2eiE3ZR4CF0Y4XQ")
      .then((value) async {
    CachedVariables.token = await CacheHelper.getData(key: CachedKeys.token);
  });
  await CacheHelper.setData(key: CachedKeys.userId, value: "40")
      .then((value) async {
    CachedVariables.userId = await CacheHelper.getData(key: CachedKeys.userId);
  });
}

Future<void> requestNotificationPermissions() async {
  final PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    await Permission.notification.request();
  } else if (status.isDenied) {
    await Permission.notification.request();
  } else if (status.isPermanentlyDenied) {
    await Permission.notification.request();
  }
}

handleNotificationNavigation(RemoteMessage message) {
  AppFunctions.logPrint(
      message:
          "Opened from notifcation Titleeee ${message.notification?.title.toString()}");
  AppFunctions.logPrint(
      message:
          "Opened from notifcation Bodyyyyyy ${message.notification?.body.toString()}");
  AppFunctions.logPrint(
      message: "Opened from notifcation Dataaaaaaa ${message.data}");
  int? id = int.tryParse(message.data["id"] ?? ''); // Safely parse the ID
  bool isCheckout =
      message.data["page"] != null ? message.data["page"] == "checkout" : true;
  double? longitude;
  double? latitude;
  if (message.data["page"] == "directions") {
    longitude = double.tryParse(message.data["longitude"] ?? "");
    latitude = double.tryParse(message.data["latitude"] ?? "");
  }

  int? classId = message.data["class"] != null
      ? int.tryParse(message.data["class"])
      : null;
  if (id != null) {
    if (isCheckout) {
      navigatorKey.currentState?.pushNamed(
        RouteConstants.sessionCheckOut,
        arguments: CheckoutModel(
            id: id, isNotification: false, isPushNotification: true),
      );
    } else {
      navigatorKey.currentState?.pushNamed(
        RouteConstants.sessions,
        arguments: SessionLocalModel(
            sessionId: id,
            isPushNotification: true,
            longitude: longitude,
            latitude: latitude,
            classId: classId),
      );
    }
  } else {
    AppFunctions.logPrint(message: "Invalid ID in notification data.");
  }

  //
  // Get.to(SessionCheckOutScreen(
  //     checkoutModel:
  //         CheckoutModel(id: message.data["id"], isNotification: false)));
  // Get.to(RouteConstants.sessionCheckOut,
  //     arguments: CheckoutModel(id: 1, isNotification: false));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DioHelper.init();
  await HiveHelper.init();
  await CacheHelper.init();
  await requestNotificationPermissions();
  Bloc.observer = MyBlocObserver();
  await Upgrader.clearSavedSettings();
  await Future.delayed(Duration(seconds: 2));
  String? fcm;
  await FirebaseMessaging.instance.getToken().then((value) {
    fcm = value;
  }).catchError((error) {
    AppFunctions.logPrint(message: 'Error getting FCM token: $error');
  });
  AppFunctions.logPrint(message: "FCM : $fcm");
  if (CachedVariables.fcmToken == null) {
    await CacheHelper.setData(key: CachedKeys.fcmToken, value: fcm ?? '');
  }
  CachedVariables.token = await CacheHelper.getData(key: CachedKeys.token);
  CachedVariables.userId = await CacheHelper.getData(key: CachedKeys.userId);
  CachedVariables.fcmToken =
      await CacheHelper.getData(key: CachedKeys.fcmToken);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    handleNotificationNavigation(message);
  });
  FirebaseMessaging.onMessage.listen((message) {
    debugPrint(
        '================================ FOREGROUND NOTIFICATION ================================');
    debugPrint(message.data.toString());
    NotificationService.initNotification();
    // NotificationService.showNotification(
    //     title: '${message.notification?.title}',
    //     body: "${message.notification?.body}");
    NotificationService.dataAction(message);
    AppFunctions.logPrint(
        message: 'Notification title: ${message.notification?.title}');
    AppFunctions.logPrint(
        message: 'Notification body: ${message.notification?.body}');
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await CacheHelper.deleteData(key: CachedKeys.token);
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', ''), Locale('ar', '')],
        path: 'assets/lang',
        fallbackLocale: const Locale('en', ''),
        child: const AppRoot()),
  );
}
