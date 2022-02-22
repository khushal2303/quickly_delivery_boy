class RequestResetPasswordAPIRequest {
  RequestResetPasswordAPIRequest({
    required this.email,
  });
  final String email;

  Map toJson() => {
        'email': email,
      };
}

class RequestResestPassResponse {
  final int code;
  final String status;
  final String message;

  RequestResestPassResponse(this.code, this.status, this.message);

  static RequestResestPassResponse fromJson(Map<String, dynamic> json) =>
      RequestResestPassResponse(
        json['code'],
        json['status'],
        json['message'],
      );
}

class ResetPasswordRequest {
  ResetPasswordRequest({
    required this.email,
    required this.resetKey,
    required this.newPassword,
  });
  final String email;
  final String resetKey;
  final String newPassword;

  Map toJson() => {
        'email': this.email,
        'reset_key': this.resetKey,
        'new_password': this.newPassword,
      };
}
