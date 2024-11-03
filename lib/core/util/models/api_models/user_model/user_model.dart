import 'package:bookit/core/util/widgets/address_widget/model/address_model.dart';
import 'package:bookit/features/auth/model/api_models/sports_model.dart';

class UserProfileModel {
  int? status;
  String? message;
  Data? data;

  UserProfileModel({this.status, this.message, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  Profile? profile;
  List<SportData>? sports;

  Data({this.profile, this.sports});

  Data.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    if (json['sports'] != null) {
      sports = <SportData>[];
      json['sports'].forEach((v) {
        sports!.add(new SportData.fromJson(v));
      });
    }
  }
}

class Profile {
  int? id;
  String? name;
  String? emailVerifiedAt;
  String? phone;
  String? gender;
  String? language;
  String? birthDate;
  String? image;
  AddressModel? country;
  AddressModel? city;
  AddressModel? area;
  String? createdAt;
  String? countryCode;
  String? updatedAt;
  List<Sports>? sports;

  Profile(
      {this.id,
      this.name,
      this.emailVerifiedAt,
      this.phone,
      this.gender,
      this.birthDate,
      this.image,
      this.country,
      this.countryCode,
      this.city,
      this.area,
      this.createdAt,
      this.updatedAt,
      this.sports});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    image = json['image'];
    language = json['language'];
    countryCode = json['country_code'];
    country = AddressModel.fromJson(json['country']);
    city = AddressModel.fromJson(json['city']);
    area = AddressModel.fromJson(json['area']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['sports'] != null) {
      sports = <Sports>[];
      json['sports'].forEach((v) {
        sports!.add(new Sports.fromJson(v));
      });
    }
  }
}

class Sports {
  int? id;
  String? name;
  String? icon;
  String? status;
  String? level;

  Sports({this.id, this.name, this.icon, this.status, this.level});

  Sports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    status = json['status'];
    level = json['level'];
  }
}
