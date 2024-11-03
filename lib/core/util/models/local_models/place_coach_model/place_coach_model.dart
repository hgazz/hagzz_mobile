import 'package:equatable/equatable.dart';

class PlaceCoachModel extends Equatable {
  final int id;
  final String image;
  final String name;
  final String department;
  final String? following;
  final String? rate;

  const PlaceCoachModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.department,
      required this.following,
      required this.rate});

  factory PlaceCoachModel.fromJson(Map<String, dynamic> json) =>
      PlaceCoachModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        department: json["department"],
        following: json["following"],
        rate: json["rate"],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, image, department, following, rate];
}
