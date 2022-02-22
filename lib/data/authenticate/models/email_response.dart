class EmailResponse {
  int? id;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  String? email;
  bool? verify;
  bool? primary;

  EmailResponse({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.email,
    this.verify,
    this.primary,
  });

  EmailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
    email = json['email'];
    verify = json['verify'];
    primary = json['primary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_deleted'] = isDeleted;
    data['email'] = email;
    data['verify'] = verify;
    data['primary'] = primary;
    return data;
  }
}
