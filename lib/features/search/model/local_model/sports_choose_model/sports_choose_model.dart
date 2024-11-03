import 'package:equatable/equatable.dart';

class SportsChooseModel extends Equatable {
  final int id;
  final String image;

  SportsChooseModel({required this.id, required this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [id, image];
}
