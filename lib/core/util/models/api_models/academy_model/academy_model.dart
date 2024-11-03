import 'package:bookit/core/util/models/api_models/gallery_model/gallery_model.dart';
import 'package:bookit/features/auth/model/api_models/sports_model.dart';

import '../training_model/training_model.dart';

class AcademyModel {
  int? id;
  String? phone;
  String? commercialName;
  String? logo;
  String? address;
  String? facebook;
  String? instagram;
  String? linkedin;
  String? website;
  int? followsCount;
  int? classesCount;
  int? coachesCount;
  int? trainingsCount;
  int? addressesCount;
  List<TrainingModel>? trainings;
  List<GalleryModel>? galleries;
  List<SportData>? sports;

  AcademyModel(
      {this.id,
      this.phone,
      this.commercialName,
      this.logo,
      this.address,
      this.facebook,
      this.instagram,
      this.followsCount,
      this.classesCount,
      this.coachesCount,
      this.trainingsCount,
      this.addressesCount,
      this.trainings,
      this.galleries,
      this.sports});

  AcademyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    commercialName = json['commercial_name'];
    logo = json['logo'];
    address = json['address'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    linkedin = json['linkedin'];
    website = json['website'];
    followsCount = json['follows_count'];
    classesCount = json['classes_count'];
    coachesCount = json['coaches_count'];
    trainingsCount = json['trainings_count'];
    addressesCount = json['addresses_count'];
    if (json['trainings'] != null) {
      trainings = <TrainingModel>[];
      json['trainings'].forEach((v) {
        trainings!.add(new TrainingModel.fromJson(v));
      });
    }
    if (json['galleries'] != null) {
      galleries = <GalleryModel>[];
      json['galleries'].forEach((v) {
        galleries!.add(new GalleryModel.fromJson(v));
      });
    }
    if (json['sports'] != null) {
      sports = <SportData>[];
      json['sports'].forEach((v) {
        sports!.add(new SportData.fromJson(v));
      });
    }
  }
}
