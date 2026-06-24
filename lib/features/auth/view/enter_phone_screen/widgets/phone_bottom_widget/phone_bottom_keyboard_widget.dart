import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/core/util/widgets/phone_field_widget/phone_field_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/auth/model/local_model/verifcation_code_local_model/verifcation_code_local_model.dart';
import 'package:bookit/features/auth/view_model/enter_phone_cubit/enter_phone_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/helper/router/rout_constants.dart';
import '../../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../../core/util/constants/app_icons/app_icons.dart';
import '../../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../../core/util/widgets/bottom_widget/bottom_widget.dart';
import '../dont_have_an_account_widget/dont_have_an_account_widget.dart';

class PhoneBottomKeyboardWidget extends StatelessWidget {
  const PhoneBottomKeyboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EnterPhoneCubit, EnterPhoneState>(
      listener: (context, state) {
        var cubit = EnterPhoneCubit.get(context);

        if (state is LoginSuccessState) {
          // AppAlert.success(
          //     message: AppFunctions.translateText(
          //         text: AppStrings.lo, context: context),
          //     context: context);
          // cubit.cachePhoneNumber();

          AppFunctions.namedNavigateTo(
            context: context,
            navigatedScreen: RouteConstants.verificationCode,
            args: VerificationCodeLocalModel(
              isLogin: true,
              phone: cubit.phoneNumberController.text.replaceAll(" ", ""),
              code: cubit.countryCode,
              isSendingViaWhatsApp: cubit.isWhatsapp,
            ),
          );

          // cubit.clearAllData();
        }
        if (state is LoginErrorState) {
          AppAlert.error(message: state.error, context: context);
        }
      },
      builder: (context, state) {
        var cubit = EnterPhoneCubit.get(context);
        return Form(
          key: cubit.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PhoneFieldWidget(
                controller: cubit.phoneNumberController,
                getCountryCode: (value) {
                  cubit.changeCountryCode(value);
                },
              ),
              SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(AppIcons.whatsapp, width: 20.w, height: 20.h),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: CustomTextWidget(
                      text: AppStrings.whatsappNumberHint,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
              if (state is UserNotFoundState)
                CustomTextWidget(
                  text: AppStrings.userNotFound,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.redColor,
                ),
              SizedBox(height: 16.h),
              // ChooseVerificationTypeComponent(
              //   getSelected: (value) {
              //     cubit.changeSelectedVerificationType(isWhatsApp: value);
              //   },
              // ),
              // SizedBox(
              //   height: 16.h,
              // ),
              BottomWidget(
                isLoading: state is! LoginLoadingState ? false : true,
                text: AppStrings.sendCode,
                onTap: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.login();
                  }
                },
              ),
              SizedBox(height: 8.h),
              DontHaveAnAccountWidget(),
            ],
          ),
        );
      },
    );
  }
}
