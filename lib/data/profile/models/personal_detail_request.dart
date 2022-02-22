class PersonalDetailRequest {
  String? firstName;
  String? lastName;
  String? fatherName;
  String? dateOfBirth;
  bool? isProfileCompletelyFilled;
  List<UserEmail>? userEmail;
  List<UserMobileNumber>? userMobileNumber;
  List<int>? groupIds;

  PersonalDetailRequest(
      {this.firstName,
      this.lastName,
      this.fatherName,
      this.dateOfBirth,
      this.isProfileCompletelyFilled,
      this.userEmail,
      this.userMobileNumber,
      this.groupIds});

  PersonalDetailRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    fatherName = json['father_name'];
    dateOfBirth = json['date_of_birth'];
    isProfileCompletelyFilled = json['is_profile_completely_filled'];
    if (json['user_email'] != null) {
      userEmail = <UserEmail>[];
      json['user_email'].forEach((v) {
        userEmail!.add(UserEmail.fromJson(v));
      });
    }
    if (json['user_mobile_number'] != null) {
      userMobileNumber = <UserMobileNumber>[];
      json['user_mobile_number'].forEach((v) {
        userMobileNumber!.add(UserMobileNumber.fromJson(v));
      });
    }
    groupIds = json['group_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['father_name'] = fatherName;
    data['date_of_birth'] = dateOfBirth;
    data['is_profile_completely_filled'] = isProfileCompletelyFilled;
    if (userEmail != null) {
      data['user_email'] = userEmail!.map((v) => v.toJson()).toList();
    }
    if (userMobileNumber != null) {
      data['user_mobile_number'] =
          userMobileNumber!.map((v) => v.toJson()).toList();
    }
    data['group_ids'] = groupIds ?? [];
    return data;
  }
}

class UserEmail {
  String? email;
  bool? verify;
  bool? primary;

  UserEmail({this.email, this.verify, this.primary});

  UserEmail.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    verify = json['verify'];
    primary = json['primary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['verify'] = verify;
    data['primary'] = primary;
    return data;
  }
}

class UserMobileNumber {
  String? mobileNumber;
  bool? verify;
  bool? primary;

  UserMobileNumber({this.mobileNumber, this.verify, this.primary});

  UserMobileNumber.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobile_number'];
    verify = json['verify'];
    primary = json['primary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mobile_number'] = mobileNumber;
    data['verify'] = verify;
    data['primary'] = primary;
    return data;
  }
}

class UserAddress {
  String? address;
  String? houseNumberAndBuildingName;
  String? streetName;
  String? landMark;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  String? addressType;
  String? notes;
  String? geoLocation;
  bool? primary;
  bool? isShipping;
  bool? isBilling;
  bool? isSetManually;
  num? userId;

  UserAddress({
    this.address,
    this.houseNumberAndBuildingName,
    this.streetName,
    this.landMark,
    this.city,
    this.state,
    this.country,
    this.pinCode,
    this.addressType,
    this.notes,
    this.geoLocation,
    this.primary,
    this.isShipping,
    this.isBilling,
    this.isSetManually,
    this.userId,
  });

  UserAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    houseNumberAndBuildingName = json['house_number_and_building_name'];
    streetName = json['street_name'];
    landMark = json['land_mark'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pinCode = json['pin_code'];
    addressType = json['address_type'];
    notes = json['notes'];
    geoLocation = json['geo_location'];
    primary = json['primary'];
    isShipping = json['is_shipping'];
    isBilling = json['is_billing'];
    isSetManually = json['is_set_manually'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address'] = address ?? "";
    data['house_number_and_building_name'] = houseNumberAndBuildingName ?? "";
    data['street_name'] = streetName ?? "";
    data['land_mark'] = landMark ?? "";
    data['city'] = city ?? "";
    data['state'] = state ?? "";
    data['country'] = country ?? "";
    data['pin_code'] = pinCode ?? "";
    data['address_type'] = addressType ?? "Home";
    data['notes'] = notes ?? "";
    data['geo_location'] = geoLocation ?? "";
    data['primary'] = primary ?? false;
    data['is_shipping'] = isShipping ?? false;
    data['is_billing'] = isBilling ?? false;
    data['is_set_manually'] = isSetManually ?? false;
    data['user_id'] = userId;
    return data;
  }
}
