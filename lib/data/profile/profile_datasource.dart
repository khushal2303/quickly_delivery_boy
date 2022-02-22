import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/data/authenticate/models/photos_response.dart';
import 'package:quickly_delivery/data/profile/models/personal_detail_request.dart';

class ProfileDataSource {
  ProfileDataSource({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<dynamic> updatePersonalDetail(
      PersonalDetailRequest personalDetailRequest) async {
    log("=======updateUserDetails========");
    log("account/profile/${Constants.userId}/");
    log(personalDetailRequest.toJson().toString());
    return await _dio.patch("account/profile/${Constants.userId}/",
        data: personalDetailRequest.toJson());
  }

  Future<dynamic> updatePersonalPhoto(Photos photos) async {
    log("=======updateUserDetails========");
    log(photos.toJson().toString());
    return await _dio.post("account/photo/", data: photos.toJson());
  }

  Future<dynamic> updateAddress(UserAddress userAddress) async {
    log("=======updateAddress========");
    log(userAddress.toJson().toString());
    return await _dio.post("account/address/", data: userAddress.toJson());
  }

  Future<dynamic> createNewDeliveryBoyId() async {
    log("=======createNewDeliveryBoyId========");
    final response = await _dio
        .post("delivery/profile/", data: {"user_id": Constants.userId});
    return response.data;
  }
}
