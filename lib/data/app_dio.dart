import 'dart:developer';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/utils/app-prefrences.dart';

class AppDio with DioMixin implements Dio {
  AppDio._([BaseOptions? options]) {
    options = BaseOptions(
      baseUrl: Constants.of().endpoint,
      contentType: 'application/json',
      connectTimeout: 30000,
      sendTimeout: 30000,
      receiveTimeout: 30000,
    );

    this.options = options;
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // options.headers.addAll(await userAgentClientHintsHeader());
          try {
            final sessionData = await AppPrefrences.instance.getSessionData();
            log("=======sessionData?.token===sessionData?.token=====");
            log(sessionData?.token?.toString() ?? "");
            if (sessionData != null && sessionData.token?.isNotEmpty == true) {
              options.headers["Authorization"] = "jwt ${sessionData.token}";
            }
          } on Exception catch (_) {}
          handler.next(options);
        },
      ),
    );

    if (kDebugMode) {
      interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));
    }

    httpClientAdapter = DefaultHttpClientAdapter();
  }
  static Dio getInstance() => AppDio._();
}
