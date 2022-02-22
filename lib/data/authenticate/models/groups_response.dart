class GroupsResponse {
  num? id;
  List<Permissions>? permissions;
  String? name;

  GroupsResponse({this.id, this.permissions, this.name});

  GroupsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    return data;
  }
}

class Permissions {
  int? id;
  String? name;
  String? codename;
  int? contentType;

  Permissions({this.id, this.name, this.codename, this.contentType});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    codename = json['codename'];
    contentType = json['content_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['codename'] = codename;
    data['content_type'] = contentType;
    return data;
  }
}
