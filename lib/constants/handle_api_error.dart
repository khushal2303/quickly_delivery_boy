import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:quickly_delivery/constants/strings.dart';

class HandleAPI {
  static String handleAPIError(e) {
    try {
      if (e is DioError) {
        if (e.response?.data is Map) {
          log("DIO ERROR");
          return e.response?.data["message"];
        } else if (e.type == DioErrorType.other) {
          if (e.message.contains("Network is unreachable")) {
            return Strings.no_internet;
          }
          return e.message;
        } else {
          return Strings.something_went_wrong;
        }
      } else {
        return e.toString();
      }
    } catch (e) {
      return Strings.something_went_wrong;
    }
  }
}
