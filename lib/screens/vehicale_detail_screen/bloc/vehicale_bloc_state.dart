part of 'vehicale_bloc_bloc.dart';

@immutable
class VehicaleState {
  final String? licenseImage;
  final String? vehicaleImage;
  final bool isLoading;

  const VehicaleState(
      {this.licenseImage, this.vehicaleImage, this.isLoading = false});

  VehicaleState copyWith(
      {String? licenseImage, String? vehicaleImage, bool? isLoading}) {
    return VehicaleState(
      licenseImage: licenseImage ?? this.licenseImage,
      vehicaleImage: vehicaleImage ?? this.vehicaleImage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class VehicaleStateFailure extends VehicaleState {
  final String error;

  const VehicaleStateFailure(this.error);
  @override
  List<Object> get props => [];
}
