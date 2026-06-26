import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/constants/app_validators/app_validators.dart';
import 'package:bookit/core/util/widgets/bottom_widget/bottom_widget.dart';
import 'package:bookit/features/auth/view/verification_code_screen/widgets/resend_code_widget/resend_code_widget.dart';
import 'package:bookit/features/auth/view/widgets/header_common_widget/header_common_widget.dart';
import 'package:bookit/features/auth/view_model/otp_cubit/otp_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/cach/cach_helper.dart';
import '../../../../core/helper/cach/cached_keys.dart';
import '../../../../core/helper/cach/cached_variables.dart';
import '../../../../core/helper/router/rout_constants.dart';
import '../../../../core/util/widgets/pin_otp_widget/pin_otp_widget.dart';
import '../../../profile/view/widgets/header_widget.dart';
import '../../../profile/view_model/profile_cubit/profile_cubit.dart';
import '../../model/local_model/verifcation_code_local_model/verifcation_code_local_model.dart';

class VerificationCodeScreen extends StatefulWidget {
  final VerificationCodeLocalModel model;

  const VerificationCodeScreen({super.key, required this.model});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarWidget(
      //   leadingWidget: Padding(
      //     padding: EdgeInsets.only(right: 4.w),
      //     child: ContainerIconWidget(
      //         icon: Icons.arrow_back,
      //         onTap: () => AppFunctions.namedNavigateAndFinishTo(
      //             context: context,
      //             navigatedScreen: RouteConstants.enterPhone)),
      //   ),
      // ),
      body: BlocProvider(
        create: (context) => OtpCubit(),
        child: BlocConsumer<OtpCubit, OtpState>(
          listener: (context, state) async {
            var cubit = OtpCubit.get(context);
            if (state is VerifyOtpSuccessState) {
              if (widget.model.isLogin) {
                if (state.lang == "en") {
                  ProfileCubit.get(context).changeLanguage(isEnglish: true);
                  final localization = EasyLocalization.of(context);
                  if (localization != null) {
                    context.setLocale(const Locale("en", ""));
                    await CacheHelper.setData(
                        key: CachedKeys.lang, value: "en");
                    CachedVariables.lang =
                        await CacheHelper.getData(key: "lang");
                  }
                } else {
                  ProfileCubit.get(context).changeLanguage(isEnglish: false);
                  final localization = EasyLocalization.of(context);
                  if (localization != null) {
                    context.setLocale(const Locale("ar", ""));
                    await CacheHelper.setData(
                        key: CachedKeys.lang, value: "ar");
                    CachedVariables.lang =
                        await CacheHelper.getData(key: "lang");
                  }
                }
              }

              AppFunctions.showSuccessDialogBox(context: context);
              cubit.cacheData(data: state.cachedData);
              cubit.clearAddressData(context: context);
              cubit.otpController.clear();
              // cubit.getUserData();
              // cubit.clearAllData(context: context);
              Future.delayed(const Duration(seconds: 3), () {
                AppFunctions.namedNavigateAndFinishTo(
                    context: context,
                    navigatedScreen: widget.model.isLogin
                        ? RouteConstants.bottomNavBar
                        : RouteConstants.chooseSports);
              });
            }

            if (state is VerifyOtpErrorState) {
              if (cubit.otpController.text != "") {
                cubit.otpController.clear();
                AppAlert.error(
                    message: AppFunctions.translateText(
                        text: AppStrings.wrongVerificationCodeMessage,
                        context: context),
                    context: context);
              } else {
                AppAlert.error(
                    message: AppFunctions.translateText(
                        text: AppStrings.verificationCodeMessage,
                        context: context),
                    context: context);
              }
            }
          },
          builder: (context, state) {
            var cubit = OtpCubit.get(context);
            return SafeArea(
              child: Column(
                children: [
                  HeaderWidget(
                    isShowBack: false,
                    backOnPressed: () {
                      AppFunctions.popNavigate(context: context);
                    },
                    title: widget.model.isLogin
                        ? AppStrings.welcomeBack
                        : AppStrings.createAnAccount,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderVerificationPasswordCommonWidget(
                          titleText: AppStrings.enterVerificationCode,
                          phone: widget.model.phone,
                          code: widget.model.code,
                          isLogin: widget.model.isLogin,
                          registerModel: widget.model.registerModel,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Center(
                          child: PinOtpWidget(
                            validator: (value) => AppValidator.generalValidator(
                                value: value ?? '', context: context),
                            controller: cubit.otpController,
                            onComplete: (pin) {
                              cubit.verifyOtp(
                                phone: widget.model.phone,
                                countryCode: widget.model.code,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        BottomWidget(
                            isLoading:
                                state is! VerifyOtpLoadingState ? false : true,
                            text: AppStrings.verify,
                            onTap: () {
                              cubit.verifyOtp(
                                phone: widget.model.phone,
                                countryCode: widget.model.code,
                              );
                            }),
                        SizedBox(
                          height: 20.h,
                        ),
                        ResendCodeWidget(
                          phone: widget.model.phone,
                          countryCode: widget.model.code,
                          isWhatsapp: widget.model.isSendingViaWhatsApp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
