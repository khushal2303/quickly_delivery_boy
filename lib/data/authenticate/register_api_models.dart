class VerifyUserRequest {
  final String mobileNumber;
  final String otp;

  VerifyUserRequest(
    this.mobileNumber,
    this.otp,
  );

  Map toJson() => {
        'mobile_number': "+91" + mobileNumber,
        'otp': otp,
      };
}
