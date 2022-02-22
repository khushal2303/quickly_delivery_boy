part of 'login_bloc.dart';

class LoginState {
  const LoginState({
    this.isBusy = false,
    this.mobileNumberError,
    this.otpError,
    this.submissionSuccess = false,
  });

  final bool isBusy;
  final FieldError? mobileNumberError;
  final FieldError? otpError;
  final bool submissionSuccess;
}

class OtpSendSuccess extends LoginState {
  final String message;

  OtpSendSuccess(this.message);
}

class OtpSendFailure extends LoginState {
  final String error;

  OtpSendFailure(this.error);
}

class UserVerifySuccess extends LoginState {
  final String message;

  UserVerifySuccess(this.message);
}

class UserVerifyFailure extends LoginState {
  final String error;

  UserVerifyFailure(this.error);
}
