part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String mobileNumber;
  const LoginSubmitted(
    this.mobileNumber,
  );
}

class VerifyOtpEvent extends LoginEvent {
  final String mobileNumber;
  final String otp;
  const VerifyOtpEvent(this.mobileNumber, this.otp);
}

class ResendOtpEvent extends LoginEvent {
  final String mobileNumber;
  const ResendOtpEvent(this.mobileNumber);
}
