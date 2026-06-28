class TrainingModel {
  int? id;
  String? name;
  String? image;
  int? price;
  int? discount;
  String? startDate;
  String? endDate;
  int? maxPlayers;
  String? level;
  String? gender;
  String? ageGroup;
  int? active;
  int? classesCount;
  int? joinsCount;
  bool? isSaved;
  Academy? academy;
  String? address;
  String? sportIcon;

  TrainingModel(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.startDate,
      this.endDate,
      this.maxPlayers,
      this.level,
      this.gender,
      this.ageGroup,
      this.active,
      this.classesCount,
      this.joinsCount,
      this.academy,
      this.isSaved,
      this.address,
      this.sportIcon});

  TrainingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = (json['price'] as num?)?.round();
    discount = (json['discount_price'] as num?)?.round();
    startDate = json['start_date'];
    endDate = json['end_date'];
    isSaved = json['is_fav'];
    maxPlayers = json['max_players'];
    level = json['level'];
    gender = json['gender'];
    ageGroup = json['age_group'];
    active = json['active'];
    classesCount = json['classes_count'];
    joinsCount = json['joins_count'];
    sportIcon = json['sport'] != null ? json['sport']["icon"] : null;
    academy =
        json['academy'] != null ? new Academy.fromJson(json['academy']) : null;
    address = json['address'] != null ? json['address']["address"] : null;
  }
}

class Academy {
  int? id;
  String? commercialName;
  String? logo;
  String? address;
  int? followsCount;

  Academy(
      {this.id,
      this.commercialName,
      this.logo,
      this.address,
      this.followsCount});

  Academy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commercialName = json['commercial_name'];
    logo = json['logo'];
    address = json['address'];
    followsCount = json["follows_count"];
  }
}
