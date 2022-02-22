part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
}

class GetCurrentLocationEvent extends LocationEvent {
  const GetCurrentLocationEvent();

  @override
  List<Object?> get props => [];
}
