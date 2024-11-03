import 'package:bookit/core/util/models/api_models/training_model/training_model.dart';

import '../../../auth/model/api_models/sports_model.dart';

class HomeModel {
  int? status;
  String? message;
  Data? data;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Banners>? banners;
  List<SportData>? sportsRelatedUserAuthenticated;
  List<AcademiesAndRelatedSports>? academies;
  List<TrainingModel>? training;
  int? trainingCount;

  Data(
      {this.banners,
      this.sportsRelatedUserAuthenticated,
      this.academies,
      this.training});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['sports related user authenticated'] != null) {
      sportsRelatedUserAuthenticated = <SportData>[];
      json['sports related user authenticated'].forEach((v) {
        sportsRelatedUserAuthenticated!.add(new SportData.fromJson(v));
      });
    }
    if (json['academies and related sports'] != null) {
      academies = <AcademiesAndRelatedSports>[];
      json['academies and related sports'].forEach((v) {
        academies!.add(new AcademiesAndRelatedSports.fromJson(v));
      });
    }
    if (json['training']["trainings"] != null) {
      training = <TrainingModel>[];
      json['training']["trainings"].forEach((v) {
        training!.add(new TrainingModel.fromJson(v));
      });
    }
    trainingCount = json["training"]["trainings_count"];
  }
}

class Banners {
  int? id;
  String? logo;

  Banners({this.id, this.logo});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    return data;
  }
}

class SportsRelatedUserAuthenticated {
  int? id;
  int? userId;
  int? sportId;
  String? level;
  SportData? sport;

  SportsRelatedUserAuthenticated(
      {this.id, this.userId, this.sportId, this.level, this.sport});

  SportsRelatedUserAuthenticated.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sportId = json['sport_id'];
    level = json['level'];
    sport =
        json['sport'] != null ? new SportData.fromJson(json['sport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['sport_id'] = this.sportId;
    data['level'] = this.level;
    if (this.sport != null) {
      data['sport'] = this.sport!.toJson();
    }
    return data;
  }
}

class AcademiesAndRelatedSports {
  int? id;
  String? commercialName;
  String? logo;
  int? followsCount;
  List<Sports>? sports;

  AcademiesAndRelatedSports(
      {this.id,
      this.commercialName,
      this.logo,
      this.sports,
      this.followsCount});

  AcademiesAndRelatedSports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commercialName = json['commercial_name'];
    followsCount = json['follows_count'];
    logo = json['logo'];
    if (json['sports'] != null) {
      sports = <Sports>[];
      json['sports'].forEach((v) {
        sports!.add(new Sports.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.commercialName != null) {
      data['commercial_name'] = this.commercialName!;
    }
    data['logo'] = this.logo;
    if (this.sports != null) {
      data['sports'] = this.sports!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sports {
  int? id;
  String? name;
  String? icon;
  String? status;
  Pivot? pivot;

  Sports({this.id, this.name, this.icon, this.status, this.pivot});

  Sports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    status = json['status'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name!;
    }
    data['icon'] = this.icon;
    data['status'] = this.status;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? academyId;
  int? sportId;

  Pivot({this.academyId, this.sportId});

  Pivot.fromJson(Map<String, dynamic> json) {
    academyId = json['academy_id'];
    sportId = json['sport_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['academy_id'] = this.academyId;
    data['sport_id'] = this.sportId;
    return data;
  }
}
