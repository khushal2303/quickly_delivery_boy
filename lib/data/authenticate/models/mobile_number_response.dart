class MobileNumber {
  int? id;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  String? mobileNumber;
  bool? verify;
  bool? primary;
  int? user;

  MobileNumber(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.isDeleted,
      this.mobileNumber,
      this.verify,
      this.primary,
      this.user});

  MobileNumber.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
    mobileNumber = json['mobile_number'];
    verify = json['verify'];
    primary = json['primary'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_deleted'] = this.isDeleted;
    data['mobile_number'] = this.mobileNumber;
    data['verify'] = this.verify;
    data['primary'] = this.primary;
    data['user'] = this.user;
    return data;
  }
}
