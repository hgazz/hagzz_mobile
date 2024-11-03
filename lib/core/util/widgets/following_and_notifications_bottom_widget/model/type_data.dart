import 'package:equatable/equatable.dart';

class TypeData extends Equatable {
  final int id;
  final String type;
  final bool isFollow;

  const TypeData({
    required this.id,
    required this.type,
    required this.isFollow,
  });

  Map<String, dynamic> toMap() => {"id": id, "type": type};

  @override
  // TODO: implement props
  List<Object?> get props => [id, type, isFollow];
}
