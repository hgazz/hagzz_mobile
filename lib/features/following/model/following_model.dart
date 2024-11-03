import 'package:bookit/core/util/constants/app_functions/app_functions.dart';

import '../../../core/util/models/local_models/place_coach_model/place_coach_model.dart';
import '../../auth/model/api_models/sports_model.dart';

class FollowingModel {
  int? status;
  String? message;
  List<PlaceCoachModel>? coaches;
  List<PlaceCoachModel>? academies;
  int? totalPages;

  FollowingModel(
      {this.status,
      this.message,
      this.coaches,
      this.academies,
      this.totalPages});

  FollowingModel.fromJson(Map<String, dynamic> json,
      {List<PlaceCoachModel>? myCoaches, List<PlaceCoachModel>? myAcademies}) {
    status = json['status'];
    message = json['message'];
    totalPages = json['data']["totalPages"];
    if (json['data'] != null) {
      coaches = <PlaceCoachModel>[];
      academies = <PlaceCoachModel>[];
      AppFunctions.logPrint(message: "Placesss${academies}");
      if (myCoaches != null) {
        coaches?.addAll(myCoaches);
      }
      if (myAcademies != null) {
        academies?.addAll(myAcademies);
      }
      json['data']["follows"].forEach((v) {
        AppFunctions.logPrint(message: "Type ${v["type"]}");
        if (v["type"] == "Coach") {
          CoachTempModel model = CoachTempModel.fromJson(v["data"]);
          coaches!.add(PlaceCoachModel(
              id: model.id ?? 0,
              image: model.image ?? '',
              name: model.name ?? '',
              department: model.sports != null
                  ? AppFunctions.getStringFromList(item: model.sports ?? [])
                  : "",
              following: null,
              rate: ""));
        } else if (v["type"] == "Academy") {
          TrainingTempModel model = TrainingTempModel.fromJson(v["data"]);
          academies!.add(PlaceCoachModel(
              id: model.id ?? 0,
              image: model.logo ?? '',
              name: model.commercialName ?? '',
              department:
                  AppFunctions.getStringFromList(item: model.sports ?? []),
              following: model.followsCount.toString(),
              rate: null));
        }
      });
    }
  }
}

class CoachTempModel {
  int? id;
  String? name;
  String? description;
  String? image;
  int? active;
  int? academyId;
  String? license;
  List<SportData>? sports;

  CoachTempModel(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.active,
      this.academyId,
      this.license});

  CoachTempModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    active = json['active'];
    academyId = json['academy_id'];
    license = json['license'];
    if (json["academy"]["sports"] != null) {
      sports = <SportData>[];
      json["academy"]['sports'].forEach((v) {
        sports!.add(new SportData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['active'] = this.active;
    data['academy_id'] = this.academyId;
    data['license'] = this.license;
    return data;
  }
}

class TrainingTempModel {
  int? id;
  String? commercialName;
  String? logo;
  int? followsCount;
  List<SportData>? sports;

  TrainingTempModel(
      {this.id, this.commercialName, this.logo, this.followsCount});

  TrainingTempModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    commercialName =
        json['commercial_name'] != null ? json['commercial_name'] : null;

    logo = json['logo'];
    followsCount = json['follows_count'];
    if (json["sports"] != null) {
      sports = <SportData>[];
      json['sports'].forEach((v) {
        sports!.add(new SportData.fromJson(v));
      });
    }
  }
}
