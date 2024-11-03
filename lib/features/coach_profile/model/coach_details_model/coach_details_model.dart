import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/models/api_models/coach_model/coach_model.dart';

class CoachDetailsModel {
  int? status;
  String? message;
  CoachDetailsData? data;

  CoachDetailsModel({this.status, this.message, this.data});

  CoachDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? CoachDetailsData.fromJson(json['data']) : null;
  }
}

class CoachDetailsData {
  bool? isFollow;
  CoachModel? coach;
  int? classesCount;
  int? usersCount;

  CoachDetailsData(
      {this.isFollow, this.coach, this.classesCount, this.usersCount});

  CoachDetailsData.fromJson(Map<String, dynamic> json) {
    isFollow = json['is_follow'];
    AppFunctions.logPrint(message: "isFollow: $isFollow");
    coach =
        json['coach'] != null ? new CoachModel.fromJson(json['coach']) : null;
    classesCount = json['classes_count'];
    usersCount = json['users_count'];
  }
}
