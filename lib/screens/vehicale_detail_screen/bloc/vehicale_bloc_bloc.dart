import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickly_delivery/constants/strings.dart';
import 'package:quickly_delivery/data/vehicale/models/vehicle_photo_request.dart';
import 'package:quickly_delivery/data/vehicale/vehicale_repository.dart';
import 'package:quickly_delivery/utils/helpers.dart';
import 'package:quickly_delivery/utils/permissions-helper.dart';

part 'vehicale_bloc_event.dart';
part 'vehicale_bloc_state.dart';

class VehicaleBloc extends Bloc<VehicaleEvent, VehicaleState> {
  final VehicaleRepository _repository;
  VehicaleBloc({required VehicaleRepository repository})
      : _repository = repository,
        super(const VehicaleState()) {
    on<VehicaleEvent>((event, emit) {});
    on<PickImage>((event, emit) => pickVehicaleImages(event, emit));

    on<RemoveImage>((event, emit) {
      if (event.isLicense) {
        emit(state.copyWith(licenseImage: ""));
      } else {
        emit(state.copyWith(vehicaleImage: ""));
      }
    });
  }

  pickVehicaleImages(PickImage event, emit) async {
    try {
      if (event.imageSource == ImageSource.camera) {
        final status = await PermissionHelper.checkForCameraPermission();
        if (status == true) {
          final result =
              await ImagePicker().pickImage(source: ImageSource.camera);
          if (result != null) {
            if (event.isLicense) {
              emit(state.copyWith(licenseImage: result.path));
            } else {
              emit(state.copyWith(vehicaleImage: result.path));
            }
          }
        } else if (status == false) {
          emit(const VehicaleStateFailure(Strings.allowCameraPermission));
        }
      } else if (event.imageSource == ImageSource.gallery) {
        final status = await PermissionHelper.checkForMediaPermission();
        if (status == true) {
          final result =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (result != null) {
            if (event.isLicense) {
              emit(state.copyWith(licenseImage: result.path));
            } else {
              emit(state.copyWith(vehicaleImage: result.path));
            }
          }
        } else if (status == false) {
          emit(const VehicaleStateFailure(Strings.allowGalleryPermission));
        }
      }
    } catch (e) {
      emit(VehicaleStateFailure(e.toString()));
    }
  }

  Future<bool> uploadVehiclePhoto(emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      VehiclePhotoRequest vehiclePhotoRequest = VehiclePhotoRequest(
          altText: "Vehicle Photo",
          createdAt: DateTime.now().toString(),
          updatedAt: DateTime.now().toString(),
          isDeleted: false,
          original:
              Helpers.base64ImageConvert(File(state.vehicaleImage ?? "")));
      final result = await _repository.updateVehicalPhoto(vehiclePhotoRequest);
      result.when(success: (success) {
        return true;
      }, failure: (failure) {
        return false;
      });
      return false;
    } catch (e) {
      return Future.value(false);
    }
  }

  submitVehicleDocument(emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      // bool uploadLicense = await uploadVehicleLicense(emit, true);
      // bool uploadPhoto = await uploadVehicleLice nse(emit, false);

      // final result = await _repository.updateVehicalPhoto(photos)
    } catch (e) {}
  }
}
