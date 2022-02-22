class Photos {
  int? id;
  String? photo;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? primary;
  num? user;
  num? userId;

  Photos({
    this.id,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.primary,
    this.user,
    this.userId,
  });

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
    primary = json['primary'];
    user = json['user'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['photo'] = photo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_deleted'] = isDeleted;
    data['primary'] = primary;
    data['user'] = user;
    data['user_id'] = userId;
    return data;
  }
}
