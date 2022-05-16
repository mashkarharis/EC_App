import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/services/apiService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCM {
  final streamCtlr = StreamController<String>.broadcast();
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   print('Handling a background message ${message.messageId}');
  // }

  Future initialize(BuildContext context, List elders) async {
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'Notification With High Importance',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                icon: 'launch_background',
                styleInformation: BigTextStyleInformation('')),
          ),
        );
      }
    });

    dynamic macs = [];

    APIService.getMACs().then((resp) => {
          if (resp.statusCode == 200)
            {
              macs = jsonDecode(resp.body),
              print("UnSubsCribe\n============"),
              macs.forEach((mac) => {
                    if (mac != null)
                      {
                        print(mac),
                        FirebaseMessaging.instance.unsubscribeFromTopic(mac)
                      }
                  }),
              print("SubsCribe\n============"),
              elders.forEach((element) {
                if (element['mac'] != null) {
                  print(element['mac']);
                  FirebaseMessaging.instance.subscribeToTopic(element['mac']);
                }
              })
            }
        });
  }
}
