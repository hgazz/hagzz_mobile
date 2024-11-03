import 'package:equatable/equatable.dart';

class SessionLocalModel extends Equatable {
  final int sessionId;
  final bool isPushNotification;
  final double? longitude;
  final double? latitude;
  final int? classId;

  SessionLocalModel(
      {required this.sessionId,
      this.isPushNotification = false,
      this.longitude,
      this.latitude,
      this.classId});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [sessionId, isPushNotification, longitude, latitude];
}
