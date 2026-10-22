import 'dart:async';

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
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/app_root/app_root.dart';
import 'core/app_root/startup_gate.dart';
import 'core/helper/cach/cach_helper.dart';
import 'core/helper/dio/dio_helper.dart';
import 'core/helper/notification_services/notification_services.dart';
import 'features/session/model/local_model/checkout_model.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) print("Handling a background message: ${message.messageId}");
}

Future<void> requestNotificationPermissions() async {
  await Permission.notification.request();
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
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(StartupGate(
      initialize: initializeApp,
      app: EasyLocalization(
        supportedLocales: const [Locale('en', ''), Locale('ar', '')],
        path: 'assets/lang',
        fallbackLocale: const Locale('en', ''),
        child: const AppRoot(),
      ),
    ));
  }, reportStartupError);
}

void reportStartupError(Object error, StackTrace stack) {
  debugPrint('Application error: ${error.runtimeType}');
  if (Firebase.apps.isNotEmpty) {
    unawaited(FirebaseCrashlytics.instance
        .recordError(error, stack, fatal: false)
        .catchError((Object _) {}));
  }
}

Future<void> initializeApp() async {
  await EasyLocalization.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await DioHelper.init();
  await HiveHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  CachedVariables.token = await CacheHelper.getData(key: CachedKeys.token);
  CachedVariables.userId = await CacheHelper.getData(key: CachedKeys.userId);
  CachedVariables.fcmToken =
      await CacheHelper.getData(key: CachedKeys.fcmToken);
  CachedVariables.onBoard = await CacheHelper.getData(key: CachedKeys.onBoard);
  CachedVariables.lang = await CacheHelper.getData(key: CachedKeys.lang);
  await CacheHelper.deleteData(key: CachedKeys.phone);
  // Notification token retrieval must never block the first screen.
  WidgetsBinding.instance.addPostFrameCallback((_) {
    unawaited(initializeNotifications());
  });
}

Future<void> initializeNotifications() async {
  try {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotificationNavigation(message);
    });
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint(
          '================================ FOREGROUND NOTIFICATION ================================');
      debugPrint(message.data.toString());
      NotificationService.initNotification();
      NotificationService.dataAction(message);
      AppFunctions.logPrint(
          message: 'Notification title: ${message.notification?.title}');
      AppFunctions.logPrint(
          message: 'Notification body: ${message.notification?.body}');
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    final fcm = await FirebaseMessaging.instance
        .getToken()
        .timeout(const Duration(seconds: 10));
    if (fcm != null) {
      await CacheHelper.setData(key: CachedKeys.fcmToken, value: fcm);
      CachedVariables.fcmToken = fcm;
    }
    await requestNotificationPermissions();
  } catch (error, stack) {
    reportStartupError(error, stack);
  }
}
