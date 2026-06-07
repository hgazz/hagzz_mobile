import 'package:bookit/core/helper/analytics/analytics_service.dart';
import 'package:bookit/core/util/widgets/address_widget/view_model/address_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/dio/dio_helper.dart';
import '../../../../core/helper/dio/end_points.dart';
import '../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../core/util/models/api_models/api_response_models/default_response_model/default_response_model.dart';
import '../../../../core/util/models/api_models/api_response_models/validation_error_model/validation_error_model.dart';
import '../../model/local_model/register_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  init() {
    emit(RegisterInitial());
  }

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var dateController = TextEditingController();
  var phoneController = TextEditingController();
  var countryController = TextEditingController();

  bool? isMale;

  void changeGender(bool? value) {
    genderValidation = null;
    isMale = value;
    emit(ChangeGenderSuccessState());
  }

  String? genderValidation;
  String? agreementValidation;

  void setGenderValidationError({required context}) {
    genderValidation = AppFunctions.translateText(
        text: AppStrings.genderValidationError, context: context);

    emit(SetGenderValidationErrorSuccessState());
  }

  void setAgreementValidationError({required context}) {
    agreementValidation = AppFunctions.translateText(
        text: AppStrings.youMustAgreePrivacyPolicyAndTermsConditions,
        context: context);

    emit(SetGenderValidationErrorSuccessState());
  }

  bool? isAgree;

  void changeAgreeTermsAndCondition() {
    isAgree ??= false;
    isAgree = !isAgree!;
    emit(ChangeAgreeTermsAndConditionSuccessState());
  }

  String? validationError;

  Future<void> register({required RegisterModel data}) async {
    emit(RegisterLoadingState());

    await DioHelper.postData(url: EndPoints.register, data: await data.toMap())
        .then((value) {
      DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
      if (value.statusCode == 200) {
        AnalyticsService.logSignUp();
        emit(RegisterSuccessState(message: model.message ?? ''));
      } else if (value.statusCode == 400) {
        RegisterValidationErrorModel model =
            RegisterValidationErrorModel.fromJson(value.data);
        validationError = model.errors?.phone?[0];
        emit(ValidationErrorState(model: model));
      } else {
        DefaultResponseModel model = DefaultResponseModel.fromJson(value.data);
        emit(RegisterErrorState(error: model.message ?? ''));
      }
    }).catchError((error) {
      AppFunctions.logPrint(message: "ERROR : $error");
      emit(RegisterErrorState(error: error.toString()));
    });
  }

  String countryCode = "+2";

  void changeCountryCode(String countryCode) {
    this.countryCode = countryCode;
    emit(ChangeCountryCodeSuccessState());
  }

  void clearAllData({required context}) {
    nameController.clear();
    dateController.clear();
    phoneController.clear();
    AddressCubit.get(context).selectedArea = null;
    AddressCubit.get(context).selectedCity = null;
    AddressCubit.get(context).selectedCountry = null;
    genderValidation = null;
    isAgree = null;
    isMale = null;
    emit(ClearRegisterAllDataSuccessState());
  }

  String? oldNumber;

  void assignDataIfTapToChange({
    required RegisterModel? data,
    required context,
  }) {
    if (data != null) {
      nameController.text = data.name;
      dateController.text = data.birthDate;
      phoneController.text = data.phone;
      oldNumber = data.phone;
      countryController.text = data.countryCode;
      AddressCubit.get(context).cities.forEach((element) {
        if (element.id == data.cityId) {
          AddressCubit.get(context).selectedCity = element;
        }
      });
      AddressCubit.get(context).countries.forEach((element) {
        if (element.id == data.countryId) {
          AddressCubit.get(context).selectedCountry = element;
        }
      });

      AddressCubit.get(context).areas.forEach((element) {
        if (element.id == data.areaId) {
          AddressCubit.get(context).selectedArea = element;
        }
      });

      isMale = data.gender == "male" ? true : false;
      isAgree = true;
      genderValidation = null;
      AppFunctions.logPrint(message: "OLddddd: $oldNumber");
      emit(AssignDataIfTapToChangeSuccessState());
    }
  }

  bool isWhatsapp = true;

  void changeSelectedVerificationType({required bool isWhatsApp}) {
    this.isWhatsapp = isWhatsApp;
    emit(ChangeSelectedTypeSuccessState());
  }
}
