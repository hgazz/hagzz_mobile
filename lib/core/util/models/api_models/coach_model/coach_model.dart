import 'package:bookit/core/util/models/api_models/academy_model/academy_model.dart';
import 'package:bookit/core/util/models/api_models/training_model/training_model.dart';

class CoachModel {
  int? id;
  String? name;
  String? description;
  String? license;
  String? licenseType;
  String? image;
  int? active;
  int? academyId;
  int? totalHours;
  int? trainingsCount;
  int? traineesCount;
  List<TrainingModel>? training;
  AcademyModel? academy;

  CoachModel(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.active,
      this.academyId,
      this.license,
      this.totalHours,
      this.academy});

  CoachModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    license = json['license'];
    active = json['active'];
    academyId = json['academy_id'];
    totalHours = json['total_hours'];
    trainingsCount = json['trainings_count'];
    traineesCount = json['trainees_count'];
    licenseType = json['license_type'];
    academy =
        json['academy'] != null ? AcademyModel.fromJson(json['academy']) : null;
    if (json['trainings'] != null) {
      training = <TrainingModel>[];
      json['trainings'].forEach((v) {
        training!.add(new TrainingModel.fromJson(v));
      });
    }
  }
}
