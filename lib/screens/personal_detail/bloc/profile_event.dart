part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class PickImage extends ProfileEvent {
  final ImageSource imageSource;
  const PickImage(this.imageSource);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SetAddressEvent extends ProfileEvent {
  final UserAddress userAddress;
  const SetAddressEvent(this.userAddress);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SetGooglePlaceId extends ProfileEvent {
  final String googlePlaceId;
  const SetGooglePlaceId(this.googlePlaceId);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateUserPersonalDetailEvent extends ProfileEvent {
  final PersonalDetailRequest personalDetailRequest;
  final Photos? photosRequest;
  final UserAddress? userAddress;
  const UpdateUserPersonalDetailEvent(
    this.personalDetailRequest,
    this.photosRequest,
    this.userAddress,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
