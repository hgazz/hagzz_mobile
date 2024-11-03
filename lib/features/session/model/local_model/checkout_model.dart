import 'package:equatable/equatable.dart';

class CheckoutModel extends Equatable {
  final int id;
  final bool isNotification;
  final bool isPushNotification;

  const CheckoutModel(
      {required this.id,
      required this.isNotification,
      this.isPushNotification = false});

  @override
  // TODO: implement props
  List<Object?> get props => [id, isNotification, isPushNotification];
}
