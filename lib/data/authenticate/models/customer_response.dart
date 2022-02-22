import 'package:quickly_delivery/data/authenticate/models/email_response.dart';
import 'package:quickly_delivery/data/authenticate/models/groups_response.dart';
import 'package:quickly_delivery/data/authenticate/models/mobile_number_response.dart';
import 'package:quickly_delivery/data/authenticate/models/photos_response.dart';

class Customer {
  num? id;
  String? username;
  bool? isSuperuser;
  String? firstName;
  String? lastName;
  List<EmailResponse>? emails;
  List<MobileNumber>? mobileNumber;
  List<dynamic>? address;
  List<Photos>? photos;
  List<GroupsResponse>? groups;

  Customer(
      {this.id,
      this.username,
      this.isSuperuser,
      this.firstName,
      this.lastName,
      this.emails,
      this.mobileNumber,
      this.address,
      this.photos,
      this.groups});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    isSuperuser = json['is_superuser'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    if (json['emails'] != null) {
      emails = <EmailResponse>[];
      json['emails'].forEach((v) {
        emails!.add(EmailResponse.fromJson(v));
      });
    }
    if (json['mobile_number'] != null) {
      mobileNumber = <MobileNumber>[];
      json['mobile_number'].forEach((v) {
        mobileNumber!.add(MobileNumber.fromJson(v));
      });
    }
    if (json['address'] != null) {
      address = <dynamic>[];
      json['address'].forEach((v) {
        address!.add(v);
      });
    }
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    if (json['groups'] != null) {
      groups = <GroupsResponse>[];
      json['groups'].forEach((v) {
        groups!.add(GroupsResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['is_superuser'] = isSuperuser;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['emails'] = emails;
    data['address'] = address;
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    if (groups != null) {
      data['groups'] = groups!.map((v) => v.toJson()).toList();
    }
    if (mobileNumber != null) {
      data['mobile_number'] = mobileNumber!.map((v) => v.toJson()).toList();
    }

    if (emails != null) {
      data['user_email'] = emails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
