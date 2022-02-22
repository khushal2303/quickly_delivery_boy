import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:quickly_delivery/data/authenticate/auth_datasource.dart';
import 'package:quickly_delivery/data/authenticate/authentication_repository.dart';
import 'package:quickly_delivery/utils/analytics_logger.dart';

import 'app.dart';
import 'data/app_dio.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AnalyticsLogger.instance.logEvent(AnalyticsLogger.app_open, null);
  // await Firebase.initializeApp();
  //if we remove this the app will get two notifications when in background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(App(
    authenticationRepository: AuthenticationRepository(
        authDataSource: AuthDataSource(
      dio: AppDio.getInstance(),
    )),
  ));
}
