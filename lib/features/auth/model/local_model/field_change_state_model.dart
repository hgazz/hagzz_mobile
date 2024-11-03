import 'package:equatable/equatable.dart';

class FieldChangeStateModel extends Equatable {
  final String fieldName;
  bool isChanged;

  FieldChangeStateModel({required this.fieldName, required this.isChanged});

  @override
  List<Object> get props => [fieldName, isChanged];
}
