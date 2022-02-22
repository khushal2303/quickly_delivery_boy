part of 'location_bloc.dart';

@immutable
class LocationState {
  const LocationState();

  LocationState copyWith() {
    return const LocationState();
  }
}

class GetCurrentLocationSuccess extends LocationState {
  final double latitude;
  final double longitude;

  const GetCurrentLocationSuccess(this.latitude, this.longitude);
  @override
  List<Object> get props => [];
}

class GetCurrentLocationFailure extends LocationState {
  final String error;

  const GetCurrentLocationFailure(this.error);
  @override
  List<Object?> get props => [];
}

class LocationGettingState extends LocationState {
  final bool isBusy;

  const LocationGettingState(this.isBusy);
  @override
  List<Object?> get props => [];
}
