import 'package:bookit/core/helper/dio/dio_helper.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/widgets/address_widget/view_model/address_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/cach/cach_helper.dart';
import '../../../../core/helper/cach/cached_keys.dart';
import '../../../../core/helper/cach/cached_variables.dart';
import '../../../../core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  ScrollController listviewController = ScrollController();

  bool isProfile = true;
  int index = 0;

  void changeShownProfile() {
    isProfile = !isProfile;
    emit(ChangeShownProfileSuccessState());
  }

  var nameController = TextEditingController();
  var dateController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var phoneNumberController = TextEditingController();
  String? token;
  String? phone;
  int? userId;

  var registerFormKey = GlobalKey<FormState>();

  Future<void> logout() async {
    emit(LogoutLoadingState());
    await DioHelper.postData(
            url: EndPoints.logout, token: CachedVariables.token)
        .then((value) {
      DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
      if (value.statusCode == 200) {
        emit(LogoutSuccessState(message: model.message ?? ''));
      } else {
        emit(LogoutErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(LogoutErrorState(error: error.toString()));
    });
  }

  DateTime endTime = DateTime.now().add(
    const Duration(
      minutes: 1,
      seconds: 0,
    ),
  );

  void changeSendCodeDuration(Duration duration) {
    if (duration != const Duration(minutes: 0, seconds: 0)) {
      DateTime.now().add(
        duration,
      );
    } else {
      endTime = DateTime.now().add(
        Duration(
          minutes: 1,
          seconds: 0,
        ),
      );
    }
    emit(ChangeSendCodeDurationSuccessState());
  }

  void clearAllData({required context}) {
    isProfile = true;
    // otpController.clear();
    nameController.clear();
    dateController.clear();
    phoneNumberController.clear();
    // isMale = null;
    // image = null;
    // chooseSports = [];
    // sportsLevel = [];
    AddressCubit.get(context).selectedCountry = null;
    AddressCubit.get(context).selectedCity = null;
    AddressCubit.get(context).selectedArea = null;
    emit(ClearAllData());
  }

  void cachedData() async {
    await CacheHelper.setData(key: CachedKeys.token, value: token ?? "")
        .then((value) async {
      CachedVariables.token = await CacheHelper.getData(key: CachedKeys.token);
    });
    await CacheHelper.setData(key: CachedKeys.userId, value: userId.toString())
        .then((value) async {
      CachedVariables.userId =
          await CacheHelper.getData(key: CachedKeys.userId);
    });
    await CacheHelper.setData(key: CachedKeys.phone, value: phone ?? '')
        .then((value) async {
      CachedVariables.phone = await CacheHelper.getData(key: CachedKeys.phone);
    });
    emit(CachedDataSuccessState());
  }

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoadingState());
    await DioHelper.getData(
            url: EndPoints.deleteAccount, token: CachedVariables.token)
        .then((value) {
      DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
      if (value.statusCode == 200) {
        emit(DeleteAccountSuccessState(message: model.message ?? ''));
      } else {
        emit(DeleteAccountErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      emit(DeleteAccountErrorState(error: error.toString()));
    });
  }
}
