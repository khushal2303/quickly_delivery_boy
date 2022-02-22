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

  UserAddress(
      {this.address,
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
      this.isSetManually});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['house_number_and_building_name'] = this.houseNumberAndBuildingName;
    data['street_name'] = this.streetName;
    data['land_mark'] = this.landMark;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pin_code'] = this.pinCode;
    data['address_type'] = this.addressType;
    data['notes'] = this.notes;
    data['geo_location'] = this.geoLocation;
    data['primary'] = this.primary;
    data['is_shipping'] = this.isShipping;
    data['is_billing'] = this.isBilling;
    data['is_set_manually'] = this.isSetManually;
    return data;
  }
}
