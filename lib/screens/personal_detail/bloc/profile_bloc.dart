import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/constants/handle_api_error.dart';
import 'package:quickly_delivery/constants/strings.dart';
import 'package:quickly_delivery/constants/valiation_mixin.dart';
import 'package:quickly_delivery/data/authenticate/models/photos_response.dart';
import 'package:quickly_delivery/data/profile/models/personal_detail_request.dart';
import 'package:quickly_delivery/data/profile/profile_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickly_delivery/utils/permissions-helper.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>
    with ValidationMixin {
  final ProfileRepository _repository;
  ProfileBloc({required ProfileRepository repository})
      : _repository = repository,
        super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});

    on<PickImage>((event, emit) => pickUserProfile(event, emit));

    on<SetAddressEvent>((event, emit) {
      emit(AddAddressSuccess(event.userAddress));
    });

    on<SetGooglePlaceId>((event, emit) {
      emit(state.copyWith(googlePlaceId: event.googlePlaceId));
    });

    on<UpdateUserPersonalDetailEvent>((event, emit) async {
      await createPersonalDetail(event, emit);
    });
  }

  createPersonalDetail(UpdateUserPersonalDetailEvent event, emit) async {
    emit(const PeronalDetailUpdateBusy(true));
    try {
      await updatePersonalDetail(event, emit);
    } catch (e) {
      emit(const PeronalDetailUpdateBusy(false));
      final message = HandleAPI.handleAPIError(e);
      emit(ProfileStateFailure(message));
    }
  }

  updatePhotoDetail(UpdateUserPersonalDetailEvent event, emit) async {
    //Upload user photo

    // emit(const PeronalDetailUpdateBusy(true));
    try {
      final addressResult =
          await _repository.updateUserPhoto(event.photosRequest!);
      addressResult.when(success: (success) async {
        await updateAddressDetail(event, emit);
      }, failure: (error) {
        emit(const PeronalDetailUpdateBusy(false));
        emit(ProfileStateFailure(error));
      });
    } catch (e) {
      emit(const PeronalDetailUpdateBusy(false));
      final message = HandleAPI.handleAPIError(e);
      emit(ProfileStateFailure(message));
    }
  }

  updateAddressDetail(UpdateUserPersonalDetailEvent event, emit) async {
    //Upload user address
    // emit(const PeronalDetailUpdateBusy(true));
    try {
      final addressResult =
          await _repository.updateUserAddress(event.userAddress!);
      addressResult.when(success: (success) async {
        log("=====updateAddressDetail=== success======");
        await createDeliveryId(event, emit);
      }, failure: (error) {
        log("=====updateAddressDetail=== failure======");
        log(error.toString());
        emit(const PeronalDetailUpdateBusy(false));
        emit(ProfileStateFailure(error));
      });
    } catch (e) {
      emit(const PeronalDetailUpdateBusy(false));
      final message = HandleAPI.handleAPIError(e);
      emit(ProfileStateFailure(message));
    }
  }

  updatePersonalDetail(UpdateUserPersonalDetailEvent event, emit) async {
    //Updated user details
    log("=========updatePersonalDetail===========");
    emit(const PeronalDetailUpdateBusy(true));
    log("=========updatePersonalDetail=====After======");
    try {
      final result =
          await _repository.updatePersonalDetail(event.personalDetailRequest);
      result.when(success: (data) async {
        log("=====updatePersonalDetail=== success======");
        await createDeliveryId(event, emit);
      }, failure: (message) {
        log("=====updatePersonalDetail=== message======");
        log(message.toString());
        emit(const PeronalDetailUpdateBusy(false));
        emit(ProfileStateFailure(message));
      });
    } catch (e) {
      emit(const PeronalDetailUpdateBusy(false));
      final message = HandleAPI.handleAPIError(e);
      emit(ProfileStateFailure(message));
    }
  }

  createDeliveryId(UpdateUserPersonalDetailEvent event, emit) async {
    //Create deliveryId
    emit(const PeronalDetailUpdateBusy(true));
    try {
      final deliveryBoyResult = await _repository.createNewDelivetBoyId();
      deliveryBoyResult.when(success: (success) async {
        log("===Success=====createNewDelivetBoyId============");
        Constants.deliveryBoyId = success;
        emit(const PeronalDetailUpdateBusy(false));
        emit(const ProfileDetailUpdateSuccess("Detail updated successfully"));
      }, failure: (error) {
        log("===Failure=====createNewDelivetBoyId============");
        log(error.toString());
        emit(const PeronalDetailUpdateBusy(false));
        emit(ProfileStateFailure(error));
      });
    } catch (e) {
      emit(const PeronalDetailUpdateBusy(false));
      final message = HandleAPI.handleAPIError(e);
      emit(ProfileStateFailure(message));
    }
  }

  pickUserProfile(PickImage event, emit) async {
    try {
      if (event.imageSource == ImageSource.camera) {
        final status = await PermissionHelper.checkForCameraPermission();
        if (status == true) {
          final result =
              await ImagePicker().pickImage(source: ImageSource.camera);
          if (result != null) {
            emit(PickProfileImageSuccess(result.path));
          }
        } else if (status == false) {
          emit(const ProfileStateFailure(Strings.allowCameraPermission));
        }
      } else if (event.imageSource == ImageSource.gallery) {
        final status = await PermissionHelper.checkForMediaPermission();
        if (status == true) {
          final result =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (result != null) {
            emit(PickProfileImageSuccess(result.path));
          }
        } else if (status == false) {
          emit(const ProfileStateFailure(Strings.allowGalleryPermission));
        }
      }
    } catch (e) {
      emit(ProfileStateFailure(e.toString()));
    }
  }
}
