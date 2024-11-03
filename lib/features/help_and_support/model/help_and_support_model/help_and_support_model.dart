import 'package:equatable/equatable.dart';

class HelpAndSupportModel extends Equatable {
  int? status;
  String? message;
  HelpAndSupportData? data;

  HelpAndSupportModel({this.status, this.message, this.data});

  HelpAndSupportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new HelpAndSupportData.fromJson(json['data'])
        : null;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        status,
        message,
        data,
      ];
}

class HelpAndSupportData extends Equatable {
  HelpData? egyptAddress;
  HelpData? qatarAddress;
  HelpData? whatsapp;
  HelpData? email;

  HelpAndSupportData(
      {this.egyptAddress, this.qatarAddress, this.whatsapp, this.email});

  HelpAndSupportData.fromJson(Map<String, dynamic> json) {
    egyptAddress = HelpData.fromJson(json["egypt_address"][0]);
    qatarAddress = HelpData.fromJson(json["qatar_address"][0]);
    email = HelpData.fromJson(json["email"][0]);
    whatsapp = HelpData.fromJson(json["whatsapp"][0]);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        qatarAddress,
        egyptAddress,
        whatsapp,
        email,
      ];
}

class HelpData extends Equatable {
  int? id;
  String? key;
  String? value;
  String? type;

  HelpData({this.id, this.key, this.value, this.type});

  HelpData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    type = json['type'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        key,
        value,
        type,
      ];
}
