import 'package:bookit/core/helper/cach/cach_helper.dart';
import 'package:bookit/core/helper/cach/cached_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/cach/cached_variables.dart';
import '../../../../core/helper/dio/dio_helper.dart';
import '../../../../core/helper/dio/end_points.dart';
import '../../../../core/util/constants/app_functions/app_functions.dart';

part 'enter_phone_state.dart';

class EnterPhoneCubit extends Cubit<EnterPhoneState> {
  EnterPhoneCubit() : super(EnterPhoneInitial());

  static EnterPhoneCubit get(context) => BlocProvider.of(context);

  bool isWhatsapp = true;

  void changeSelectedVerificationType({required bool isWhatsApp}) {
    this.isWhatsapp = isWhatsApp;
    emit(ChangeSelectedTypeSuccessState());
  }

  var formKey = GlobalKey<FormState>();
  var phoneNumberController = TextEditingController();

  Future<void> login() async {
    emit(LoginLoadingState());
    await DioHelper.postData(
          url: EndPoints.login,
          data: {
            "phone": phoneNumberController.text.replaceAll(" ", ""),
            "fcm_token": await CachedVariables.fcmToken,
            "country_code": countryCode,
            "send_type": "whatsapp",
          },
        )
        .then((value) {
          if (value.statusCode == 200) {
            emit(LoginSuccessState());
          } else if (value.statusCode == 400) {
            emit(UserNotFoundState());
          }
        })
        .catchError((error) {
          AppFunctions.logPrint(message: "Error $error");
          emit(LoginErrorState(error: error.toString()));
        });
  }

  String countryCode = "+20";

  void changeCountryCode(String countryCode) {
    this.countryCode = countryCode;
    emit(ChangeCountryCodeSuccessState());
  }

  void clearAllData() {
    phoneNumberController.clear();
    emit(ClearLoginAllDataState());
  }

  void checkCachedPhone() async {
    CachedVariables.phone = await CacheHelper.getData(key: CachedKeys.phone);
    if (CachedVariables.phone != null) {
      phoneNumberController.text = CachedVariables.phone ?? '';
    }
    emit(CheckCachedPhoneNumberState());
  }

  Future<void> cachePhoneNumber() async {
    await CacheHelper.setData(
      key: CachedKeys.phone,
      value: phoneNumberController.text,
    ).then((value) async {
      CachedVariables.phone = await CacheHelper.getData(key: CachedKeys.phone);
      emit(CachedPhoneNumberState());
    });
  }
}
