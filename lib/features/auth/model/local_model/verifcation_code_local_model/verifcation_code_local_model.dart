import 'package:equatable/equatable.dart';

import '../register_model.dart';

class VerificationCodeLocalModel extends Equatable {
  final bool isLogin;
  final String phone;
  final String code;
  final bool isSendingViaWhatsApp;
  final RegisterModel? registerModel;

  VerificationCodeLocalModel(
      {required this.isLogin,
      required this.phone,
      required this.code,
      required this.isSendingViaWhatsApp,
      this.registerModel});

  @override
  // TODO: implement props
  List<Object?> get props => [isLogin, phone, code, registerModel];
}
