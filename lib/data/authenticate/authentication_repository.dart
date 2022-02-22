import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/constants/handle_api_error.dart';
import 'package:quickly_delivery/data/api_result.dart';
import 'package:quickly_delivery/data/authenticate/auth_datasource.dart';
import 'package:quickly_delivery/utils/analytics_logger.dart';
import 'package:quickly_delivery/utils/app-prefrences.dart';

import 'login_api_models.dart';
import 'register_api_models.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({
    required AuthDataSource authDataSource,
  }) : _authDataSource = authDataSource;

  final AuthDataSource _authDataSource;

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    final isLoggedIN = await AppPrefrences.instance.checkUserLoggedIn();
    if (isLoggedIN) {
      final user = await AppPrefrences.instance.getSessionData();
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<dynamic> logIn({
    required String mobileNumber,
  }) async {
    final result = await _authDataSource.authenticateUser(
        request: LoginRequest(
      mobileNumber,
    ));
    return result;
  }

  Future<dynamic> resendOtp({
    required String mobileNumber,
  }) async {
    final result = await _authDataSource.resendOtp(
        request: ResendOtpRequest(
      mobileNumber,
    ));
    return result;
  }

  Future<dynamic> verifyUser(mobileNumber, verificationCode) async {
    final result = await _authDataSource.verifyUser(
        request: VerifyUserRequest(
      mobileNumber,
      verificationCode,
    ));
    if (result != null && result is UserResponse) {
      AnalyticsLogger.instance
          .logEvent(AnalyticsLogger.veriry_user, result.toJson());
      Constants.userId = result.user?.id ?? 0;
      await AppPrefrences.instance.setUserLoggedIn(true);
      await AppPrefrences.instance.saveSessionData(result);
      _controller.add(AuthenticationStatus.authenticated);
    }
  }

  Future<ApiResult<bool>> logOut() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    try {
      final response = await _authDataSource.logout(fcmToken);
      if (response.data["code"] == 200) {
        AppPrefrences.instance.setUserLoggedIn(false);
        _controller.add(AuthenticationStatus.unauthenticated);
        return const ApiResult.success(data: true);
      } else {
        return ApiResult.failure(
          error: response.data["message"],
        );
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(
        error: message,
      );
    }
  }

  void dispose() => _controller.close();
}
