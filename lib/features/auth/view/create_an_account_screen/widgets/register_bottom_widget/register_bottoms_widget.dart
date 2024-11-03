import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/address_widget/view_model/address_cubit.dart';
import 'package:bookit/features/auth/model/local_model/register_model.dart';
import 'package:bookit/features/auth/model/local_model/verifcation_code_local_model/verifcation_code_local_model.dart';
import 'package:bookit/features/auth/view_model/register_cubit/register_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/util/constants/app_alert/app_alert.dart';
import '../../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../../core/util/widgets/bottom_widget/bottom_widget.dart';

class RegisterBottomWidget extends StatelessWidget {
  const RegisterBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        var cubit = RegisterCubit.get(context);

        if (state is RegisterSuccessState) {
          AppAlert.success(message: state.message, context: context);
          AppFunctions.namedNavigateAndFinishTo(
              context: context,
              navigatedScreen: RouteConstants.verificationCode,
              args: VerificationCodeLocalModel(
                  isLogin: false,
                  phone: cubit.phoneController.text.replaceAll(" ", ""),
                  code: cubit.countryCode,
                  isSendingViaWhatsApp: cubit.isWhatsapp,
                  registerModel: RegisterModel(
                      isWhatsapp: cubit.isWhatsapp,
                      phone: cubit.phoneController.text.replaceAll(" ", ""),
                      name: cubit.nameController.text,
                      countryCode: cubit.countryCode,
                      birthDate: cubit.dateController.text,
                      gender: cubit.isMale ?? true ? "male" : "female",
                      countryId: AddressCubit.get(context)
                              .selectedCountry
                              ?.id
                              .toString() ??
                          "",
                      cityId: AddressCubit.get(context)
                              .selectedCity
                              ?.id
                              .toString() ??
                          "",
                      areaId: AddressCubit.get(context)
                              .selectedArea
                              ?.id
                              .toString() ??
                          "")));
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return BottomWidget(
            isLoading: state is! RegisterLoadingState ? false : true,
            text: AppStrings.sendCode,
            onTap: () {
              cubit.validationError = null;
              if (cubit.isAgree == null || cubit.isAgree == false) {
                AppAlert.error(
                    message: AppFunctions.translateText(
                      text: AppStrings
                          .youMustAgreePrivacyPolicyAndTermsConditions,
                      context: context,
                    ),
                    context: context);
              }
              // if (cubit.isMale == null) {
              //   cubit.setGenderValidationError(context: context);
              // }

              if (cubit.formKey.currentState?.validate() ?? true) {
                if ((cubit.isAgree != null && cubit.isAgree != false)) {
                  cubit.register(
                      data: RegisterModel(
                          phone: cubit.phoneController.text.replaceAll(" ", ""),
                          name: cubit.nameController.text,
                          countryCode: cubit.countryCode,
                          isWhatsapp: cubit.isWhatsapp,
                          oldPhone: cubit.oldNumber,
                          birthDate: cubit.dateController.text.isNotEmpty
                              ? cubit.dateController.text
                              : "2000-09-01",
                          gender: cubit.isMale ?? true ? "male" : "female",
                          countryId: AddressCubit.get(context)
                                  .selectedCountry
                                  ?.id
                                  .toString() ??
                              "",
                          cityId: AddressCubit.get(context)
                                  .selectedCity
                                  ?.id
                                  .toString() ??
                              "",
                          areaId: AddressCubit.get(context)
                                  .selectedArea
                                  ?.id
                                  .toString() ??
                              ""));
                }
              }
            });
      },
    );
  }
}
