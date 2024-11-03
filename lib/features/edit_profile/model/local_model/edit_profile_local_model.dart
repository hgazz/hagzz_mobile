import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/helper/cach/cached_variables.dart';

class EditProfileLocalModel extends Equatable {
  final String phone;
  final String countryCode;
  final String name;
  final String birthDate;
  final String gender;
  final String countryId;
  final String cityId;
  final String areaId;
  String? image;

  EditProfileLocalModel({
    required this.phone,
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.countryId,
    required this.cityId,
    required this.areaId,
    required this.countryCode,
    this.image,
  });

  Future<Map<String, dynamic>> toMap() async {
    Map<String, dynamic> map = {
      "phone": phone,
      "name": name,
      "gender": gender,
      "fcm_token": CachedVariables.fcmToken,
      "birth_date": birthDate,
      "country_id": countryId,
      "city_id": cityId,
      "area_id": areaId,
      "country_code": countryCode,
      if (image != null) "image": await MultipartFile.fromFile(image!)
    };

    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        phone,
        name,
        birthDate,
        gender,
        countryId,
        cityId,
        areaId,
        countryCode,
        image,
      ];
}
