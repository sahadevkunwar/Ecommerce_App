import 'dart:async';

import 'package:ecommerce_project/common/services/notification_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationWrapper extends StatefulWidget {
  final Widget child;
  const NotificationWrapper({super.key, required this.child});

  @override
  State<NotificationWrapper> createState() => _NotificationWrapperState();
}

class _NotificationWrapperState extends State<NotificationWrapper> {
  StreamSubscription? notificationSubscription;
  @override
  void initState() {
    super.initState();
    initializeNotification();
  }

  initializeNotification() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final firebaseToken = await FirebaseMessaging.instance.getToken();
    print(firebaseToken);

    notificationSubscription = FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        LocalNotificationService().generateNotification(
          title: message.notification!.title!,
          description: message.notification!.body!,
        );
      }
      print(message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    notificationSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
