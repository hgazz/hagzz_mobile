import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:dio/dio.dart';

import '../../../../core/helper/cach/cached_variables.dart';

class RegisterModel {
  final String phone;
  final String countryCode;
  final String name;
  final String birthDate;
  final String gender;
  final String countryId;
  final String cityId;
  final String areaId;
  final bool isWhatsapp;
  String? image;
  String? oldPhone;

  RegisterModel({
    required this.phone,
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.countryId,
    required this.cityId,
    required this.areaId,
    required this.countryCode,
    required this.isWhatsapp,
    this.image,
    this.oldPhone,
  });

  Future<Map<String, dynamic>> toMap() async {
    AppFunctions.logPrint(message: "Old Numberrrrr::: ${oldPhone}");
    Map<String, dynamic> map = {
      "phone": phone,
      "name": name,
      "gender": gender,
      "fcm_token": CachedVariables.fcmToken,
      "birthdate": birthDate,
      "country_id": countryId,
      "lang": await CachedVariables.lang,
      "city_id": cityId,
      "area_id": areaId,
      "country_code": countryCode,
      "send_type": isWhatsapp ? "whatsapp" : "sms",
      if (oldPhone != null) "old_phone": oldPhone,
      if (image != null) "image": await MultipartFile.fromFile(image!)
    };

    return map;
  }
}
