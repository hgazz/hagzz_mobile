import 'package:bookit/core/util/models/api_models/training_model/training_model.dart';

class ExploreResponseModel {
  int? status;
  String? message;
  Data? data;

  ExploreResponseModel({this.status, this.message, this.data});

  ExploreResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<TrainingModel>? trainings;
  int? total;
  int? page;
  int? pageSize;
  int? totalPages;

  Data({this.trainings, this.total, this.page, this.pageSize, this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['trainings'] != null) {
      trainings = <TrainingModel>[];
      json['trainings'].forEach((v) {
        trainings!.add(new TrainingModel.fromJson(v));
      });
    }
    total = json['total'];
    // page = json['page'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
  }
}
