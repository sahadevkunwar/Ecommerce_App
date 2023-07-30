import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._();
  LocalNotificationService._();
  factory LocalNotificationService() {
    return _instance;
  }
  final FlutterLocalNotificationsPlugin _flutterLocalNotifications =
      FlutterLocalNotificationsPlugin();
  initialize() {
    _requestPermission();
    _handleForForeGroundNotification();
  }

  _handleForForeGroundNotification() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const initializationSetting = InitializationSettings(
        android: AndroidInitializationSettings('ic_launcher'));
    _flutterLocalNotifications.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (details) {});
  }

  _requestPermission() async {
    _flutterLocalNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  generateNotification({
    required String title,
    required String description,
    String? payload,
  }) {
    _flutterLocalNotifications.show(
      Random().nextInt(1000),
      title,
      description,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "ecommerce_app",
          "basic",
        ),
      ),
      payload: payload,
    );
  }
}
