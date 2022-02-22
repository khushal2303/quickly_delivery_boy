import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as Location;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import '../app.dart';

class LocationHelper {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showPermissionAlertDialog(
          navigatorKey.currentContext!,
          "Location Permission",
          "You have denied location permission many times, Please the permission for batter experience");
      // bool isOpenApp = await openAppSettings();
      return Future.value(Geolocator.getCurrentPosition());
      // Future.error(
      //   'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  static Future<bool> serviceEnabled() async {
    Location.Location location = Location.Location();
    return location.serviceEnabled();
  }

  static Future<LocationData?> currentLocation() async {
    LocationData? currentLocation;
    var location = Location.Location();
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  static Future<bool> requestService() {
    Location.Location location = Location.Location();
    return location.requestService();
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
            child: const Text('Settings'),
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
