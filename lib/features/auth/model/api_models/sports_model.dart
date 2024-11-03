class SportsModel {
  int? status;
  String? message;
  List<SportData>? data;

  SportsModel({this.status, this.message, this.data});

  SportsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['errors'] != null) {
      data = <SportData>[];
      json['errors'].forEach((v) {
        data!.add(new SportData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['errors'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SportData {
  int? id;
  String? name;
  String? icon;
  String? status;
  String? level;

  SportData({this.id, this.name, this.icon, this.status, this.level});

  SportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    status = json['status'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name!;
    }
    data['icon'] = this.icon;
    data['status'] = this.status;
    data['level'] = this.level;
    return data;
  }
}
