class VehiclePhotoRequest {
  num? id;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  String? altText;
  String? original;

  VehiclePhotoRequest(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.isDeleted,
      this.altText,
      this.original});

  VehiclePhotoRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
    altText = json['alt_text'];
    original = json['original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_deleted'] = isDeleted;
    data['alt_text'] = altText;
    data['original'] = original;
    return data;
  }
}
