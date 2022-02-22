import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'login_api_models.dart';
import 'register_api_models.dart';

class AuthDataSource {
  AuthDataSource({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<dynamic> authenticateUser({
    required LoginRequest request,
  }) async {
    final response =
        await _dio.post("account/otp/send/", data: json.encode(request));
    return response.data;
  }

  Future<dynamic> resendOtp({
    required ResendOtpRequest request,
  }) async {
    final response =
        await _dio.post("account/otp/resend/", data: json.encode(request));
    return response.data;
  }

  Future<dynamic> verifyUser({
    required VerifyUserRequest request,
  }) async {
    final response = await _dio.post(
      "account/otp/verify/",
      data: json.encode(request),
    );
    return UserResponse.fromJson(response.data['data']);
  }

  Future<dynamic> logout(fcmtoken) async {
    return await _dio.post("/v1/logout", data: {
      'firebase_token': fcmtoken,
    });
  }
}
