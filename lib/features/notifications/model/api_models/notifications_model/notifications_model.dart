class NotificationsModel {
  int? status;
  String? message;
  Data? data;

  NotificationsModel({this.status, this.message, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<NotificationData>? newNotifications;
  List<NotificationData>? pastNotifications;
  int? newTotalPages;
  int? pastTotalPages;

  Data({
    this.newNotifications,
    this.pastNotifications,
    this.newTotalPages,
    this.pastTotalPages,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['unread_notifications'] != null) {
      newNotifications = <NotificationData>[];
      json['unread_notifications'].forEach((v) {
        newNotifications?.add(new NotificationData.fromJson(v));
      });
    }
    if (json['read_notifications'] != null) {
      pastNotifications = <NotificationData>[];
      json['read_notifications'].forEach((v) {
        pastNotifications?.add(new NotificationData.fromJson(v));
      });
    }
    newTotalPages = json['total_unread_notifications'];
    pastTotalPages = json['total_read_notifications'];
  }
}

class NotificationData {
  String? id;
  String? title;
  String? description;
  String? academyImage;
  String? type;
  String? createdAt;
  TrainingData? training;

  NotificationData({this.id, this.title, this.description});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    title = json['title'];

    description = json['data'];

    type = json['type'];
    createdAt = json['created_at'];

    academyImage = json['image'];

    training = json['details'] != null
        ? new TrainingData.fromJson(json['details'])
        : null;
  }
}

class TrainingData {
  int? id;
  dynamic longitude;
  dynamic latitude;
  String? trainingName;

  TrainingData({this.id, this.longitude, this.latitude});

  TrainingData.fromJson(Map<String, dynamic> json) {
    id = json['training_id'];
    trainingName = json['training_name'];

    longitude = json['longitude'] != null ? json['longitude'] : null;
    latitude = json['latitude'] != null ? json['latitude'] : null;
  }
}
