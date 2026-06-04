import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import 'package:bookit/core/util/models/api_models/error_response_model/error_response_model.dart';
import 'package:bookit/features/session/model/enum_model/enum_details_models.dart';
import 'package:bookit/features/session/model/training_details_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geideapay/common/geidea.dart';
import 'package:geideapay/common/server_environments.dart';
import 'package:geideapay/models/address.dart';
import 'package:geideapay/widgets/checkout/checkout_options.dart';

import '../../edit_profile/view_model/edit_profile_cubit.dart';
import '../model/payment_data_model/payment_data_model.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(SessionInitial());

  static SessionCubit get(context) => BlocProvider.of(context);

  final ScrollController classIndicatorScrollController = ScrollController();

  SessionDetailsCategories sessionDetailsCategories =
      SessionDetailsCategories.details;

  var pageController = PageController();

  int selectedClassIndex = 1;

  void changeSelectedClassIndex({required int i}) {
    selectedClassIndex = i;
    classIndicatorScrollController.animateTo(
      (i - 1) * 42 + (i - 1) * 8,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    emit(ChangeSelectedClassIndexSuccessState(index: selectedClassIndex));
  }

  void changeDetailsCategory({required SessionDetailsCategories category}) {
    if (category == SessionDetailsCategories.details) {
      pageController.animateToPage(0,
          duration: Duration(microseconds: 1), curve: Curves.bounceInOut);
    } else if (category == SessionDetailsCategories.classes) {
      pageController.animateToPage(1,
          duration: Duration(microseconds: 1), curve: Curves.bounceInOut);
    } else {
      pageController.animateToPage(2,
          duration: Duration(microseconds: 1), curve: Curves.bounceInOut);
    }
    sessionDetailsCategories = category;
    emit(ChangeSessionDetailsCategorySuccessState(
        category: sessionDetailsCategories));
  }

  // integration with the backend
  TrainingDetailsResponseModel? trainingDetailsResponseModel;

  bool? isFav;
  List<String> outcomes = [];

  Future<void> getTrainingDetailsById({required int id, int? classId}) async {
    trainingDetailsResponseModel = null;
    isFav = null;
    emit(GetTrainingDetailsByIdLoadingState());
    await DioHelper.getData(
      url: EndPoints.trainingDetails(id: id),
      token: CachedVariables.token,
    ).then((value) {
      if (value.statusCode == 200) {
        trainingDetailsResponseModel =
            TrainingDetailsResponseModel.fromJson(value.data);
        isFav = trainingDetailsResponseModel?.data?.training?.isFav ?? false;
        AppFunctions.logPrint(
            message: "Joinssss: ${trainingDetailsResponseModel?.data?.joins}");
        if (classId != null) {
          changeDetailsCategory(category: SessionDetailsCategories.classes);
          int index = trainingDetailsResponseModel?.data?.training?.classes
                  ?.indexWhere((e) => e.id == classId) ??
              1;
          changeSelectedClassIndex(i: index != -1 ? index + 1 : 2);
        }
        emit(GetTrainingDetailsByIdSuccessState());
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(GetTrainingDetailsByIdErrorState(model.message ?? ''));
      }
    }).catchError((error) {
      AppFunctions.logPrint(message: "Error: ${error.toString()}");
      emit(GetTrainingDetailsByIdErrorState(error.toString()));
    });
  }

  // join the training session
  Future<bool> joinTrainingSession(
      String invoiceId, String orderId, Training training) async {
    emit(JoinTrainingSessionLoadingState());
    bool isJoined = trainingDetailsResponseModel?.data?.isJoined ?? false;
    final CancelToken cancelToken = CancelToken();
    if (isClosed) {
      cancelToken.cancel();
    }
    await DioHelper.postData(
      url: EndPoints.addJoin,
      token: CachedVariables.token,
      cancelToken: cancelToken,
      data: {
        'training_id': training.id,
        'price': training.price,
        'invoice_id': invoiceId,
        'payment_status': 'Paid',
        'payment_order_id': orderId,
      },
    ).then((value) {
      if (isClosed) {
        cancelToken.cancel();
      }
      if (value.statusCode == 200) {
        isJoined = true;
        emit(JoinTrainingSessionSuccessState());
      } else {
        errorMessage = value.data['message'];

        emit(JoinTrainingSessionErrorState(value.data['message']));
        return false;
      }
    }).catchError((error) {
      if (isClosed) {
        cancelToken.cancel();
      }
      if (!isClosed) {
        emit(JoinTrainingSessionErrorState(error));
      }
    });
    return isJoined;
  }

  changeFavValue({required bool value}) {
    isFav = value;
    trainingDetailsResponseModel?.data?.training?.isFav = value;
    AppFunctions.logPrint(message: "Changed Value : $isFav");
    emit(ChangeFavValueSuccessState());
  }

  final geideaPayment = GeideapayPlugin();

  initPayment() {
    geideaPayment.initialize(
        publicKey: "3448c010-87b1-41e7-9771-cac444268cfb",
        apiPassword: "edfd5eee-fd1b-4932-9ee1-d6d9ba7599f0",
        serverEnvironment: ServerEnvironmentModel(
            'PayTech', 'https://api.merchant.geidea.net'));

    emit(InitialPaymentSdkSuccessState());
  }

  void openPayment() {
    emit(OpenPaymentSuccessState());
  }

  String? errorMessage;

  Future<void> buildPaymentSdk(
      {required context, required double price}) async {
    String city =
        EditProfileCubit.get(context).userModel?.data?.profile?.city?.name ??
            '';
    String area =
        EditProfileCubit.get(context).userModel?.data?.profile?.area?.name ??
            '';
    Address billingAddress =
        Address(city: city, countryCode: "EGY", street: area, postCode: "123");
    Address shippingAddress =
        Address(city: city, countryCode: "EGY", street: area, postCode: "123");
    CheckoutOptions checkoutOptions = CheckoutOptions(price, "EGP",
        returnUrl: "https://www.hagzz.com",
        shippingAddress: shippingAddress,
        billingAddress: billingAddress);
    emit(BuildPaymentSdkLoadingState());
    try {
      await geideaPayment
          .checkout(context: context, checkoutOptions: checkoutOptions)
          .then((value) async {
        AppFunctions.logPrint(message: 'Responseeeeeeeeeee = $value');
        if (value.responseCode == "000" && value.responseMessage == "Success") {
          AppFunctions.logPrint(
              message: "Order Idddd: ${value.order?.orderId}");
          emit(BuildPaymentSdkSuccessState(
              orderId: value.order?.orderId ?? "0",
              invoiceId: value.order?.orderId ?? '0'));
        } else {
          errorMessage = value.responseMessage;
          if (!isClosed) {
            emit(BuildPaymentSdkErrorState(error: value.responseMessage ?? ''));
          }
        }

        if (kDebugMode) print("Order ID: ${value.detailedResponseCode}");
      }).catchError((error) {
        AppFunctions.logPrint(message: 'Error = ${error.toString()}');
        if (!isClosed) {
          emit(BuildPaymentSdkErrorState(error: error.toString()));
        }
      });
    } catch (e) {
      AppFunctions.logPrint(message: 'Error = ${e.toString()}');
      if (!isClosed) {
        emit(BuildPaymentSdkErrorState(error: e.toString()));
      }
    }
  }

  Future<void> cancelJoin({required String reason}) async {
    emit(CancelBookingLoadingState());
    await DioHelper.postData(
            url: EndPoints.cancelJoin,
            data: {
              "id": trainingDetailsResponseModel?.data?.training?.id,
              "reason": reason
            },
            token: CachedVariables.token)
        .then((value) {
      if (value.data["status"] == 200) {
        emit(CancelBookingSuccessState());
      } else {
        ErrorResponseModel model = ErrorResponseModel.fromJson(value.data);
        emit(CancelBookingErrorState(error: model));
      }
    }).catchError((error) {
      emit(CancelBookingErrorState(
          error: ErrorResponseModel(message: error.toString())));
    });
  }

  bool isDrag = true;

  void changeDraggableState({
    required bool isDraggable,
  }) {
    isDrag = isDraggable;
    emit(ChangeDraggableStateSuccessState());
  }

  PaymentModel? paymentData;

  Future<void> getPayment({required int id}) async {
    paymentData = null;
    emit(GetPaymentDataLoadingState());
    await DioHelper.postData(
        url: EndPoints.payment,
        token: CachedVariables.token,
        data: {"training_id": id}).then((value) {
      if (value.statusCode == 200 && value.data["status"] == null) {
        paymentData = PaymentModel.fromJson(value.data);
        emit(GetPaymentDataSuccessState());
      } else if (value.data["status"] == 400 && value.data["status"] != null) {
        errorMessage = value.data["errors"] != null
            ? value.data["errors"]["price"]
            : "Something went wrong";
        emit(GetPaymentDataErrorState(
            error: ErrorResponseModel(
                message: value.data["errors"] != null
                    ? value.data["errors"]["price"]
                    : "Something went wrong")));
      } else {
        emit(GetPaymentDataErrorState(
            error: ErrorResponseModel(message: value.data["message"])));
      }
    }).catchError((error) {
      emit(GetPaymentDataErrorState(
          error: ErrorResponseModel(message: error.toString())));
    });
  }
}
