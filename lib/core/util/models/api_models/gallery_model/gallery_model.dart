class GalleryModel {
  int? id;
  String? image;
  int? academyId;
  String? createdAt;
  String? updatedAt;

  GalleryModel(
      {this.id, this.image, this.academyId, this.createdAt, this.updatedAt});

  GalleryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    academyId = json['academy_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['academy_id'] = this.academyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
