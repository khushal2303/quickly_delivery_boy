import 'dart:async';
import 'dart:developer';

import 'package:quickly_delivery/constants/handle_api_error.dart';
import 'package:quickly_delivery/data/api_result.dart';
import 'package:quickly_delivery/data/authenticate/models/photos_response.dart';
import 'package:quickly_delivery/data/profile/models/personal_detail_request.dart';
import 'package:quickly_delivery/data/profile/profile_datasource.dart';

class ProfileRepository {
  ProfileRepository(this._profileDataSource);

  final ProfileDataSource _profileDataSource;

  Future<ApiResult<bool>> updatePersonalDetail(
      PersonalDetailRequest personalDetailRequest) async {
    try {
      final response =
          await _profileDataSource.updatePersonalDetail(personalDetailRequest);
      log("=========updatePersonalDetail===Response=====");
      log(response.toString());
      return const ApiResult.success(data: true);
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(
        error: message,
      );
    }
  }

  Future<ApiResult<bool>> updateUserPhoto(Photos photos) async {
    try {
      final response = await _profileDataSource.updatePersonalPhoto(photos);
      log("=========updateUserPhoto===Response=====");
      log(response.toString());
      return const ApiResult.success(data: true);
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(
        error: message,
      );
    }
  }

  Future<ApiResult<bool>> updateUserAddress(UserAddress userAddress) async {
    try {
      final response = await _profileDataSource.updateAddress(userAddress);
      log("=========updateUserAddress===Response=====");
      log(response.toString());
      return const ApiResult.success(data: true);
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(
        error: message,
      );
    }
  }

  Future<ApiResult<num>> createNewDelivetBoyId() async {
    try {
      final response = await _profileDataSource.createNewDeliveryBoyId();
      log("=========createNewDelivetBoyId===Response=====");
      log(response.toString());
      if ((response as Map<String, dynamic>)['id'] != null) {
        return ApiResult.success(data: response['id']);
      } else {
        return ApiResult.success(data: response['message']);
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(
        error: message,
      );
    }
  }
}
