part of 'profile_bloc.dart';

@immutable
class ProfileState {
  const ProfileState({
    this.personalDetailRequest,
    this.googlePlaceId,
  });

  final PersonalDetailRequest? personalDetailRequest;
  final String? googlePlaceId;

  ProfileState copyWith(
      {PersonalDetailRequest? personalDetailRequest, String? googlePlaceId}) {
    return ProfileState(
      personalDetailRequest:
          personalDetailRequest ?? this.personalDetailRequest,
      googlePlaceId: googlePlaceId ?? this.googlePlaceId,
    );
  }
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileUpdateSuccess extends ProfileState {
  final String message;

  const ProfileUpdateSuccess(this.message);
  @override
  List<Object> get props => [];
}

class ProfileStateFailure extends ProfileState {
  final String error;

  const ProfileStateFailure(this.error);
  @override
  List<Object> get props => [error];
}

class PickProfileImageSuccess extends ProfileState {
  final String imagePath;

  const PickProfileImageSuccess(this.imagePath);
  @override
  List<Object> get props => [];
}

class AddAddressSuccess extends ProfileState {
  final UserAddress userAddress;

  const AddAddressSuccess(this.userAddress);
  @override
  List<Object?> get props => [userAddress];
}

class ProfileDetailUpdateSuccess extends ProfileState {
  final String message;

  const ProfileDetailUpdateSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class PeronalDetailUpdateBusy extends ProfileState {
  final bool isBusy;

  const PeronalDetailUpdateBusy(this.isBusy);
  @override
  List<Object?> get props => [isBusy];
}
