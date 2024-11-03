import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:equatable/equatable.dart';

import '../payment_data_model/payment_data_model.dart';
import '../training_details_response_model.dart';

class WebViewDataModel extends Equatable {
  final Training training;
  final PaymentModel paymentData;
  final SessionCubit cubit;

  WebViewDataModel({
    required this.training,
    required this.paymentData,
    required this.cubit,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        training,
        paymentData,
      ];
}
