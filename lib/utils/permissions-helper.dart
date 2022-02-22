import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickly_delivery/app.dart';

class PermissionHelper {
  static Future<bool?> checkForMediaPermission() async {
    if (Platform.isIOS) {
      var status = await Permission.photos.request();

      if (status.isPermanentlyDenied) {
        showPermissionAlertDialog(
            navigatorKey.currentContext!,
            "Photos Permission",
            "You denied photo permission many times, Please give the permission to access Photo");
        return null;
      } else if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        showPermissionAlertDialog(
            navigatorKey.currentContext!,
            "Storage Permission",
            "You denied camera storage many times, Please give the permission to access Storage");
        return null;
      } else {
        return false;
      }
    }
  }

  static Future<bool?> checkForCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      showPermissionAlertDialog(
          navigatorKey.currentContext!,
          "Camera Permission",
          "You denied camera permission many times, Please give the permission to access Camera");
      return null;
    } else {
      return false;
    }
  }

  static locationPermissionEnabled() async =>
      await Permission.location.isGranted;

  static Future<bool?> checkForLocationPermission() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      showPermissionAlertDialog(
          navigatorKey.currentContext!,
          "Location Permission",
          "You have denied location permission many times, Please the permission for batter experience");
      return null;
    } else {
      return false;
    }
  }

  static void showPermissionAlertDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('Deny'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: const Text("Settings"),
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
