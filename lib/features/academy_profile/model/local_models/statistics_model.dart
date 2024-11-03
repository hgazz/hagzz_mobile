import 'package:equatable/equatable.dart';

class StatisticsModel extends Equatable {
  final int id;
  final String image;
  final int numberOfCoaches;
  final int numberOfTrainers;
  final int numberOfLocations;
  final String name;
  final int followers;
  final String specialization;
  final bool isFollow;

  const StatisticsModel({
    required this.id,
    required this.image,
    required this.numberOfCoaches,
    required this.numberOfTrainers,
    required this.numberOfLocations,
    required this.name,
    required this.followers,
    required this.specialization,
    required this.isFollow,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        numberOfTrainers,
        numberOfLocations,
        numberOfCoaches,
        name,
        followers,
        specialization,
        isFollow,
        id,
        image
      ];
}
