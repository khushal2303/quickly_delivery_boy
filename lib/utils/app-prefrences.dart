import 'dart:convert';
import 'package:quickly_delivery/data/authenticate/login_api_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefrences {
  AppPrefrences._privateConstructor();

  static final AppPrefrences instance = AppPrefrences._privateConstructor();

  final String _fcmToken = "fcm-token";
  final String _isUserLoggedIn = "user-loggedIn";
  final String _sessionData = "session-data";

  Future<void> saveFCMToken(token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_fcmToken, token);
    return;
  }

  Future<String> getFCMToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_fcmToken) ?? "";
  }

  Future<void> setUserLoggedIn(value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_isUserLoggedIn, value);
    if (!value) {
      saveSessionData(null);
    }
    return;
  }

  Future<bool> checkUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_isUserLoggedIn) ?? false;
  }

  Future<void> saveSessionData(UserResponse? result) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_sessionData, jsonEncode(result?.toJson()));
  }

  Future<UserResponse?> getSessionData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString(_sessionData);
    if (session == 'null' || session == null) {
      return null;
    } else if (session.isNotEmpty) {
      return UserResponse.fromJson(jsonDecode(session));
    }
  }
}
