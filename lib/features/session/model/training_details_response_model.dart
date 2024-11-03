import 'package:bookit/features/auth/model/api_models/sports_model.dart';

class TrainingDetailsResponseModel {
  int? status;
  String? message;
  Data? data;

  TrainingDetailsResponseModel({this.status, this.message, this.data});

  TrainingDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Training? training;
  int? academyFollow;
  bool? isJoined;
  List<Joins>? joins;

  Data({this.training, this.academyFollow, this.isJoined});

  Data.fromJson(Map<String, dynamic> json) {
    training = json['training'] != null
        ? new Training.fromJson(json['training'])
        : null;
    academyFollow = json['academy_follow'];
    isJoined = json['is_joined'];
    if (json['joins'] != null) {
      joins = <Joins>[];
      json['joins'].forEach((v) {
        joins!.add(Joins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.training != null) {
      data['training'] = this.training!.toJson();
    }
    data['academy_follow'] = this.academyFollow;
    data['is_joined'] = this.isJoined;
    return data;
  }
}

class Training {
  int? id;
  String? name;
  String? image;
  int? price;
  String? startDate;
  String? endDate;
  String? description;
  int? maxPlayers;
  String? level;
  String? gender;
  String? ageGroup;
  int? active;
  int? sportId;
  bool? isFav;
  Coach? coach;
  Academy? academy;
  SportData? sport;
  AddressData? address;
  List<Classes>? classes;

  num? discountPrice;
  num? classesCount;
  num? joinsCount;

  Training({
    this.id,
    this.name,
    this.image,
    this.price,
    this.startDate,
    this.endDate,
    this.description,
    this.maxPlayers,
    this.level,
    this.gender,
    this.ageGroup,
    this.active,
    this.sportId,
    this.isFav,
    this.coach,
    this.academy,
    this.address,
    this.classes,
    this.discountPrice,
    this.classesCount,
    this.joinsCount,
    this.sport,
  });

  Training.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    maxPlayers = json['max_players'];
    level = json['level'];
    gender = json['gender'];
    ageGroup = json['age_group'];
    active = json['active'];
    sportId = json['sport_id'];
    sport = json['sport'] != null ? SportData.fromJson(json['sport']) : null;
    isFav = json['is_fav'];
    coach = json['coach'] != null ? new Coach.fromJson(json['coach']) : null;
    academy =
        json['academy'] != null ? new Academy.fromJson(json['academy']) : null;
    address = json['address'] != null
        ? new AddressData.fromJson(json['address'])
        : null;
    if (json['classes'] != null) {
      classes = <Classes>[];
      json['classes'].forEach((v) {
        classes!.add(new Classes.fromJson(v));
      });
    }

    discountPrice = json['discount_price'];
    classesCount = json['classes_count'];
    joinsCount = json['joins_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['max_players'] = this.maxPlayers;
    data['level'] = this.level;
    data['gender'] = this.gender;
    data['age_group'] = this.ageGroup;
    data['active'] = this.active;
    data['sport_id'] = this.sportId;
    data['is_fav'] = this.isFav;
    if (this.coach != null) {
      data['coach'] = this.coach!.toJson();
    }
    if (this.academy != null) {
      data['academy'] = this.academy!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.classes != null) {
      data['classes'] = this.classes!.map((v) => v.toJson()).toList();
    }
    // if (this.joins != null) {
    //   data['joins'] = this.joins!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Coach {
  int? id;
  String? name;
  String? image;

  Coach({this.id, this.name, this.image});

  Coach.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Academy {
  int? id;
  String? commercialName;
  String? logo;
  List<Sports>? sports;
  List<Follows>? follows;
  int? followsCount;

  Academy({this.id, this.commercialName, this.logo, this.sports, this.follows});

  Academy.fromJson(Map<String, dynamic> json) {
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
    if (json['follows'] != null) {
      follows = <Follows>[];
      json['follows'].forEach((v) {
        follows!.add(new Follows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['commercial_name'] = this.commercialName;
    data['logo'] = this.logo;
    if (this.sports != null) {
      data['sports'] = this.sports!.map((v) => v.toJson()).toList();
    }
    if (this.follows != null) {
      data['follows'] = this.follows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sports {
  int? id;
  String? name;
  Pivot? pivot;

  Sports({this.id, this.name, this.pivot});

  Sports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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

class Follows {
  int? id;
  int? userId;
  String? followableType;
  int? followableId;

  Follows({this.id, this.userId, this.followableType, this.followableId});

  Follows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    followableType = json['followable_type'];
    followableId = json['followable_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['followable_type'] = this.followableType;
    data['followable_id'] = this.followableId;
    return data;
  }
}

class AddressData {
  int? id;
  String? address;
  String? longitude;
  String? latitude;

  AddressData({this.id, this.address, this.longitude, this.latitude});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}

class Classes {
  int? id;
  String? title;
  String? subtitle;
  String? date;
  String? startTime;
  String? endTime;
  List<String>? outComes;
  List<String>? bringWithMe;

  Classes(
      {this.id,
      this.title,
      this.subtitle,
      this.date,
      this.startTime,
      this.endTime,
      this.outComes,
      this.bringWithMe});

  Classes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    if (json["out_comes"] != null) {
      outComes = <String>[];
      json["out_comes"].forEach((v) {
        outComes!.add(v ?? '');
      });
    }
    if (json["bring_with_me"] != null) {
      bringWithMe = <String>[];
      json["bring_with_me"].forEach((v) {
        if (v != null) {
          bringWithMe!.add(v ?? '');
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.subtitle != null) {
      data['subtitle'] = this.subtitle;
    }
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['out_comes'] = this.outComes;
    data['bring_with_me'] = this.bringWithMe;
    return data;
  }
}

class Subtitle {
  String? en;
  String? ar;

  Subtitle({this.en, this.ar});

  Subtitle.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}

class Joins {
  int? id;
  String? image;

  Joins({this.id, this.image});

  Joins.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
