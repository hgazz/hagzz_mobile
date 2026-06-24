import 'dart:async';
import 'dart:io';

import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/features/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:bookit/features/session/model/training_details_response_model.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skipcash/payment_response_class.dart';
import 'package:skipcash/skipcash.dart';

import '../../../../../core/helper/cach/cached_variables.dart';
import '../../../../../core/helper/dio/end_points.dart';
import '../../../../../core/util/constants/app_alert/app_alert.dart';
import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/bottom_widget/bottom_widget.dart';
import '../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';
import '../../../../profile/view/widgets/bottom_sheet_widget.dart';
import '../failed_bottom_sheet_widget.dart';

class ChoosePaymentBottomSheetWidget extends StatefulWidget {
  final SessionCubit cubit;

  const ChoosePaymentBottomSheetWidget({
    super.key,
    required this.cubit,
  });

  @override
  State<ChoosePaymentBottomSheetWidget> createState() =>
      _ChoosePaymentBottomSheetWidgetState();
}

class _ChoosePaymentBottomSheetWidgetState
    extends State<ChoosePaymentBottomSheetWidget> {
  late Skipcash _newPayment;
  StreamSubscription<dynamic>? _applePayResponseSubscription; // ios - applepay
  StreamSubscription<dynamic>?
      responseScPaymentDataSubscription; // android/ios - pay via webview
  bool isLoading = false;

  @override
  void initState() {
    _newPayment = Skipcash(
      merchantIdentifier: "merchant.com.hagzz.app",
      createPaymentLinkEndPoint:
          "${EndPoints.baseUrl}${EndPoints.payment}?training_id=${widget.cubit.trainingDetailsResponseModel?.data?.training?.id ?? 0}",
      authorizationHeader: "Bearer ${CachedVariables.token}",
    );
    super.initState();
    _setupApplePayResponseListener(context);
  }

  void _setupApplePayResponseListener(context) {
    _applePayResponseSubscription =
        _newPayment.applePayResponseStream.listen((response) {
      AppFunctions.logPrint(message: "Responseeeee: ${response.toString()}");
      PaymentResponse paymentResponse = PaymentResponse.fromJson(response);
      AppFunctions.logPrint(
          message: "Paument Dataaaaa: ${paymentResponse.errorMessage}");
      AppFunctions.logPrint(
          message: "Paument Dataaaaa: ${paymentResponse.returnCode}");
      AppFunctions.logPrint(
          message: "Paument Dataaaaa: ${paymentResponse.errorMessage}");

      if (paymentResponse.isSuccess) {
        AppFunctions.popNavigate(context: context);

        widget.cubit
            .joinTrainingSession(
                paymentResponse.transactionId,
                paymentResponse.transactionId,
                widget.cubit.trainingDetailsResponseModel?.data?.training ??
                    Training())
            .then((value) {
          if (value == true) {
            AppFunctions.showSuccessDialogBox(
                context: context,
                child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 0),
                    ),
                    onPressed: () {
                      widget.cubit.getTrainingDetailsById(
                          id: widget.cubit.trainingDetailsResponseModel?.data
                                  ?.training?.id ??
                              0);
                      AppFunctions.popNavigate(context: context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0.h),
                      child: CustomTextWidget(
                        text: AppStrings.backToTraining,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    )));
          } else {
            showModalBottomSheet(
              context: context,
              builder: (context) => BottomSheetWidget(
                height: MediaQuery.of(context).size.height * 0.45,
                child: FailedBottomSheetWidget(
                  error: widget.cubit.errorMessage ??
                      AppFunctions.translateText(
                          text: AppStrings.pleaseTryAgain, context: context),
                ),
              ),
            );
          }
        });
      } else {
        AppFunctions.popNavigate(context: context);

        showModalBottomSheet(
          context: context,
          builder: (context) => BottomSheetWidget(
            height: MediaQuery.of(context).size.height * 0.45,
            child: FailedBottomSheetWidget(
              error: widget.cubit.errorMessage ??
                  AppFunctions.translateText(
                      text: AppStrings.pleaseTryAgain, context: context),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        BottomWidget(
            text: AppStrings.creditCard,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppIcons.card,
                  width: 20.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                CustomTextWidget(
                  text: AppStrings.creditCard,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                )
              ],
            ),
            onTap: () {
              widget.cubit.getPayment(
                  id: widget.cubit.trainingDetailsResponseModel?.data?.training
                          ?.id ??
                      0);
              AppFunctions.popNavigate(context: context);
            },
            isLoading: false),
        Platform.isIOS
            ? SizedBox(
                height: 10.h,
              )
            : SizedBox.shrink(),
        Platform.isIOS
            ? BottomWidget(
                text: AppStrings.applePay,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppIcons.apple),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomTextWidget(
                      text: AppStrings.applePay,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    )
                  ],
                ),
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  AppFunctions.logPrint(
                      message:
                          "EndPointtt : ${"${EndPoints.baseUrl}${EndPoints.payment}"}");
                  AppFunctions.logPrint(
                      message: "Token : ${CachedVariables.token}");
                  try {
                    var total = widget.cubit.trainingDetailsResponseModel?.data
                                ?.training?.discountPrice !=
                            0
                        ? widget.cubit.trainingDetailsResponseModel?.data
                                ?.training?.discountPrice ??
                            widget.cubit.trainingDetailsResponseModel?.data
                                ?.training?.price
                        : widget.cubit.trainingDetailsResponseModel?.data
                            ?.training?.price;

                    AppFunctions.logPrint(message: "Total ${total}");
                    var userData =
                        EditProfileCubit.get(context).userModel?.data?.profile;
                    AppFunctions.logPrint(
                        message: "Nameeee:  ${userData?.name}");

                    bool hasCard =
                        await _newPayment.isWalletHasCards() ?? false;
                    AppFunctions.logPrint(message: "Has : ${hasCard}");
                    try {
                      if (hasCard) {
                        _newPayment.setFirstName(userData?.name ?? '');
                        _newPayment.setLastName(userData?.name ?? '');
                        _newPayment.merchantName = "Mesk Hagzz";
                        _newPayment.setAmount(total.toString());
                        _newPayment.setPhone('01070809633'); // mandatory
                        _newPayment.addPaymentSummaryItem("Tax", "0.0");
                        _newPayment.addPaymentSummaryItem(
                            "Total", total.toString());
                        _newPayment.startPayment();
                      } else {
                        _newPayment.setupNewCard();
                      }
                    } on PlatformException catch (e) {
                      AppFunctions.logPrint(
                          message: "Errorrr Exception : ${e.toString()}");
                      AppAlert.error(
                          message: e.message ?? '', context: context);
                    } catch (e) {
                      AppFunctions.logPrint(
                          message: "Errorrr : ${e.toString()}");
                      AppAlert.error(message: e.toString(), context: context);
                    }
                  } catch (e) {
                    AppFunctions.logPrint(message: "Errorrr : ${e.toString()}");
                    AppAlert.error(message: e.toString(), context: context);
                  }
                  Future.delayed(Duration(seconds: 1), () {
                    setState(() {
                      isLoading = false;
                    });
                  });
                },
                isLoading: isLoading,
                backgroundColor: AppColors.lemonColor,
                textColor: AppColors.black,
              )
            : SizedBox.shrink()
      ],
    );
  }
}
