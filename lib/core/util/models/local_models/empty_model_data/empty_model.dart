import 'package:equatable/equatable.dart';

class EmptyModel extends Equatable {
  final String image;
  final String title;
  final String description;
  bool? isFollowing;

  EmptyModel(
      {required this.image,
      required this.title,
      required this.description,
      this.isFollowing});

  @override
  // TODO: implement props
  List<Object?> get props => [image, title, description, isFollowing];
}
