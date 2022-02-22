import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickly_delivery/utils/location-helper.dart';
import 'package:quickly_delivery/utils/permissions-helper.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState()) {
    on<LocationEvent>((event, emit) {});

    on<GetCurrentLocationEvent>((event, emit) async {
      emit(const LocationGettingState(true));
      var status = await PermissionHelper.checkForLocationPermission();
      print("====*+++STATUE PERMISSION+++++++++++***STATUE PERMISSION*****");
      print(status.toString());
      if (status != null) {
        if (status == true) {
          Position? position = await snapLocation();
          if (position != null) {
            emit(const LocationGettingState(false));
            emit(GetCurrentLocationSuccess(
                position.latitude, position.longitude));
          }
        } else {
          emit(const LocationGettingState(false));
          emit(const GetCurrentLocationFailure(
              "Please allow the location permission"));
        }
      }
    });
  }

  Future<Position?> snapLocation() async {
    try {
      bool _serviceEnabled = await LocationHelper.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await LocationHelper.requestService();
        if (!_serviceEnabled) {
          return null;
        }
      }
      final position = await LocationHelper.determinePosition();
      return position;
    } catch (e) {
      return null;
    }
  }
}
