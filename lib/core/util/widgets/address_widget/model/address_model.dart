import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  int? id;
  String? name;

  AddressModel({this.id, this.name});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name!;
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
      ];
}
