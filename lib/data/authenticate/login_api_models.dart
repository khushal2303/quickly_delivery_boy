import 'package:quickly_delivery/data/authenticate/models/customer_response.dart';

class LoginRequest {
  final String mobileNumber;

  LoginRequest(this.mobileNumber);

  Map toJson() => {
        'mobile_number': "+91" + mobileNumber,
        'group_ids': [6],
      };
}

class ResendOtpRequest {
  final String mobileNumber;

  ResendOtpRequest(this.mobileNumber);

  Map toJson() => {
        'mobile_number': "+91" + mobileNumber,
        "retry_type": "text",
      };
}

class UserResponse {
  String? token;
  Customer? user;

  UserResponse({this.token, this.user});

  UserResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? Customer.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
