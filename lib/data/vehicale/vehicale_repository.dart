import 'dart:async';
import 'dart:developer';

import 'package:quickly_delivery/constants/handle_api_error.dart';
import 'package:quickly_delivery/data/api_result.dart';
import 'package:quickly_delivery/data/vehicale/models/vehicle_photo_request.dart';
import 'package:quickly_delivery/data/vehicale/vehicale_datasource.dart';

class VehicaleRepository {
  VehicaleRepository(this._vehicaleDataSource);

  final VehicaleDataSource _vehicaleDataSource;

  Future<ApiResult<VehiclePhotoRequest>> updateVehicalPhoto(
      VehiclePhotoRequest photos) async {
    try {
      final response = await _vehicaleDataSource.updateVehicalPhoto(photos);
      return ApiResult.success(data: VehiclePhotoRequest.fromJson(response));
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(
        error: message,
      );
    }
  }
}
