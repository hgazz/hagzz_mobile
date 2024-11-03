import 'package:bookit/core/util/models/api_models/academy_model/academy_model.dart';

class AcademyDetailsModel {
  int? status;
  String? message;
  AcademyData? data;

  AcademyDetailsModel({this.status, this.message, this.data});

  AcademyDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AcademyData.fromJson(json['data']) : null;
  }
}

class AcademyData {
  AcademyModel? academy;
  bool? isFollowing;

  AcademyData({this.academy, this.isFollowing});

  AcademyData.fromJson(Map<String, dynamic> json) {
    academy =
        json['academy'] != null ? AcademyModel.fromJson(json['academy']) : null;
    isFollowing = json['isFollowing'];
  }
}
