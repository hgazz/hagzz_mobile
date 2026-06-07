import 'package:bookit/core/helper/cach/cach_helper.dart';
import 'package:bookit/core/helper/cach/cached_keys.dart';
import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/analytics/analytics_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/dio/dio_helper.dart';
import '../../../../core/helper/dio/end_points.dart';
import '../../../../core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import '../../../../core/util/widgets/address_widget/view_model/address_cubit.dart';
import '../../model/local_model/cached_data_model/cached_data_model.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  static OtpCubit get(context) => BlocProvider.of(context);

  var otpController = TextEditingController();

  String? whatsOtp;

  Future<void> sendVerificationCodeViaWhatsApp({
    required String phone,
    required String name,
  }) async {
    emit(SendOtpViaWhatsAppLoadingState());
    await DioHelper.postData(
        url: "https://beon-system.unlimited-software.com/api/send/message/otp",
        data: {
          "phoneNumber": phone,
          "name": name
        },
        headers: {
          "beon-token": "vSCuMzZwLjDxzR882YphwEgW",
          "Content-Type": "application/json",
          "Accept": "application/json"
        }).then((value) {
      if (value.data["status"] == 200) {
        whatsOtp = value.data["data"];
        emit(SendOtpViaWhatsAppSuccessState(message: value.data["message"]));
      } else {
        emit(SendOtpViaWhatsAppSuccessState(message: value.data["message"]));
      }
    }).catchError((error) {
      emit(SendOtpViaWhatsAppSuccessState(message: error.toString()));
    });
  }

  Future<void> determineVerify({required String phone}) async {
    if (whatsOtp != null) {
      verifyOtpViaWhatsApp();
    } else {
      await verifyOtp(phone: phone);
    }
  }

  verifyOtpViaWhatsApp() {
    Future.delayed(Duration(seconds: 2), () {
      if (whatsOtp == otpController.text) {
        // emit(VerifyOtpSuccessState(
        //     model: model,
        //     cachedData: CachedDataModel(
        //         token: value.data["data"]["token"],
        //         userId: (value.data["data"]["user"]["id"]).toString()),
        //     lang: value.data["data"]["user"]["language"]));
      } else {}
    });
  }

  Future<void> verifyOtp({required String phone}) async {
    emit(VerifyOtpLoadingState());
    await DioHelper.postData(url: EndPoints.verifyCode, data: {
      "otp": otpController.text,
      "phone_number": phone,
    }).then((value) {
      DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
      if (value.statusCode == 200) {
        AnalyticsService.logLogin();
        emit(VerifyOtpSuccessState(
            model: model,
            cachedData: CachedDataModel(
                token: value.data["data"]["token"],
                userId: (value.data["data"]["user"]["id"]).toString()),
            lang: value.data["data"]["user"]["language"]));
      } else if (value.statusCode == 400) {
        emit(VerifyOtpErrorState(error: value.data["errors"]["otp"][0]));
      } else {
        emit(VerifyOtpErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(VerifyOtpErrorState(error: error.toString()));
    });
  }

  bool isTimerEnd = false;

  void changeTimerState({required bool isFinish}) {
    isTimerEnd = isFinish;
    emit(ChangeTimerState());
  }

  Future<void> resendOtp(
      {required String phone, required bool isWhatsapp}) async {
    emit(ResendOtpLoadingState());
    await DioHelper.postData(url: EndPoints.resendOtp, data: {
      "phone": phone,
      "send_type": isWhatsapp ? "whatsapp" : "sms"
    }).then((value) {
      DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
      if (value.statusCode == 200) {
        isTimerEnd = false;
        emit(ResendOtpSuccessState(message: model.message ?? ''));
      } else {
        emit(ResendOtpErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(ResendOtpErrorState(error: error.toString()));
    });
  }

  Future<void> cacheData({required CachedDataModel data}) async {
    await CacheHelper.setData(key: CachedKeys.token, value: data.token)
        .then((value) async {
      CachedVariables.token = await CacheHelper.getData(key: CachedKeys.token);
      await CacheHelper.setData(key: CachedKeys.userId, value: data.userId)
          .then((value) async {
        CachedVariables.userId =
            await CacheHelper.getData(key: CachedKeys.userId);
        emit(CachedUserDataSuccessState());
      });
    });
  }

  void clearAddressData({required context}) {
    AddressCubit.get(context).selectedArea = null;
    AddressCubit.get(context).selectedCity = null;
    AddressCubit.get(context).selectedCountry = null;
    emit(ClearAddressDataSuccessState());
  }
}
