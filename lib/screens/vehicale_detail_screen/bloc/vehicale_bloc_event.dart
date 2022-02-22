part of 'vehicale_bloc_bloc.dart';

abstract class VehicaleEvent extends Equatable {
  const VehicaleEvent();
}

class PickImage extends VehicaleEvent {
  final ImageSource imageSource;
  final bool isLicense;
  const PickImage(this.imageSource, this.isLicense);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RemoveImage extends VehicaleEvent {
  final bool isLicense;
  const RemoveImage(this.isLicense);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SubmitVehicleDocuments extends VehicaleEvent {
  final String vehicleNumber;
  const SubmitVehicleDocuments(this.vehicleNumber);

  @override
  // TODO: implement props
  List<Object?> get props => [vehicleNumber];
}
