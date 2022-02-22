import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<dynamic> onSelectNotification(payload) async {
    try {
      print("onselect notification");
      // ChatNotificationObj obj;
      // //payload will be map if called from the homepage when app is in opened state
      // if (payload is String) {
      //   Map valueMap = json.decode(payload);
      //   obj = ChatNotificationObj.fromJson(valueMap);
      // } else {
      //   obj = ChatNotificationObj.fromJson(payload);
      // }
      //
      // //Helpers.showToast(message: obj.type ?? "");
      // if (obj.type == EnumToString.convertToString(NotificationType.chat)) {
      //   if (navigatorKey.currentContext != null) {
      //     Navigator.push(
      //       navigatorKey.currentContext!,
      //       ChatScreenRoute.route(
      //         peerId: obj.senderId ?? "",
      //         userAvatar: obj.senderAvtar ?? "",
      //         userName: obj.senderName ?? "",
      //       ),
      //     );
      //   }
      // }
      // print(obj.toString());
    } catch (e) {
      // Helpers.showToast(message: e.toString());
      print(e);
    }
  }

  static void requestNotificationPermission() async {
    //notification permission for iOS
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static void configLocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  static void showNotification({
    required String? title,
    required String? body,
    required String? payload,
  }) async {
    configLocalNotification();

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'camospace.mobile.camospace',
      'Camospace',
      '',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
