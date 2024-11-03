

class AllAreaResponseModel {
  int? status;
  String? message;
  List<AreaModel>? data;

  AllAreaResponseModel({this.status, this.message, this.data});

  AllAreaResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AreaModel>[];
      json['data'].forEach((v) {
        data!.add(AreaModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AreaModel {
  int? id;
  String? name;

  AreaModel({this.id, this.name});

  AreaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!;
    }
    return data;
  }
}
