import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/data/vehicale/models/vehicle_photo_request.dart';

class VehicaleDataSource {
  VehicaleDataSource({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<dynamic> updateVehicalPhoto(VehiclePhotoRequest photos) async {
    log("=======updateVehicalPhoto========");
    log(photos.toJson().toString());
    return await _dio.post("delivery/vehicle-photos/", data: photos.toJson());
  }
}
