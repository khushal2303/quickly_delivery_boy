import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quickly_delivery/constants/field_error.dart';
import 'package:quickly_delivery/constants/handle_api_error.dart';
import 'package:quickly_delivery/constants/valiation_mixin.dart';
import 'package:quickly_delivery/data/authenticate/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with ValidationMixin {
  final AuthenticationRepository _authenticationRepository;
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginSubmitted>((event, emit) async {
      await loginSubmit(event, emit);
    });

    on<VerifyOtpEvent>((event, emit) async {
      await verifyOtp(event, emit);
    });

    on<ResendOtpEvent>((event, emit) async {
      await resendOtp(event, emit);
    });
  }

  loginSubmit(LoginSubmitted event, emit) async {
    emit(const LoginState(isBusy: true));
    try {
      if (event.mobileNumber.isEmpty == true) {
        emit(const LoginState(mobileNumberError: FieldError.Empty));
        return;
      }
      if (event.mobileNumber.length != 10) {
        emit(const LoginState(mobileNumberError: FieldError.Invalid));
        return;
      }
      final result = await _authenticationRepository.logIn(
          mobileNumber: event.mobileNumber);
      emit(const LoginState(isBusy: false));
      emit(OtpSendSuccess("Otp sent successfully"));
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      emit(const LoginState(isBusy: false));
      emit(OtpSendFailure(message));
    }
  }

  verifyOtp(VerifyOtpEvent event, emit) async {
    emit(const LoginState(isBusy: true));
    try {
      if (event.otp.isEmpty == true) {
        emit(const LoginState(otpError: FieldError.Empty));
        return;
      }
      if (event.otp.length != 4) {
        emit(const LoginState(otpError: FieldError.Invalid));
        return;
      }
      final result = await _authenticationRepository.verifyUser(
          event.mobileNumber, event.otp);
      emit(const LoginState(isBusy: false));
      emit(UserVerifySuccess("Verify successfully"));
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      emit(const LoginState(isBusy: false));
      emit(UserVerifyFailure(message));
    }
  }

  resendOtp(ResendOtpEvent event, emit) async {
    emit(const LoginState(isBusy: true));
    try {
      final result = await _authenticationRepository.resendOtp(
          mobileNumber: event.mobileNumber);
      emit(const LoginState(isBusy: false));
      emit(OtpSendSuccess("Otp sent successfully"));
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      emit(const LoginState(isBusy: false));
      emit(OtpSendFailure(message));
    }
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {}
}
