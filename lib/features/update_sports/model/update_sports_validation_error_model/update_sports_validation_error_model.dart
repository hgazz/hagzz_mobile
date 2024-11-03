class UpdateSportsValidationErrorModel {
  int? status;
  String? message;
  UpdateSportsValidationError? errors;

  UpdateSportsValidationErrorModel({this.status, this.message, this.errors});

  UpdateSportsValidationErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors = json['errors'] != null
        ? new UpdateSportsValidationError.fromJson(json['errors'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class UpdateSportsValidationError {
  List<String>? sportId;
  List<String>? level;

  UpdateSportsValidationError({this.sportId, this.level});

  UpdateSportsValidationError.fromJson(Map<String, dynamic> json) {
    sportId = json['sport_id'].cast<String>();
    level = json['level'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sport_id'] = this.sportId;
    data['level'] = this.level;
    return data;
  }
}
