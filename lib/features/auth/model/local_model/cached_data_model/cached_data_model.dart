import 'package:equatable/equatable.dart';

class CachedDataModel extends Equatable {
  final String token;
  final String userId;

  CachedDataModel({required this.token, required this.userId});

  @override
  List<Object?> get props => [token, userId];
}
