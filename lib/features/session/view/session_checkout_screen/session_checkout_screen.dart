import 'package:bookit/core/helper/analytics/analytics_service.dart';
import 'package:bookit/core/helper/review/review_service.dart';
import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/loading_widget/loading_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/session/model/payment_data_model/payment_data_model.dart';
import 'package:bookit/features/session/model/web_view_data_model/web_view_data_model.dart';
import 'package:bookit/features/session/view/session_checkout_screen/widgets/session_checkout_details_widget.dart';
import 'package:bookit/features/session/view/session_checkout_screen/widgets/session_checkout_summary_widget.dart';
import 'package:bookit/features/session/view/session_checkout_screen/widgets/session_checkout_total_widget.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../profile/view/widgets/bottom_sheet_widget.dart';
import '../../../profile/view/widgets/header_widget.dart';
import '../../model/local_model/checkout_model.dart';
import '../../model/training_details_response_model.dart';
import '../widgets/failed_bottom_sheet_widget.dart';
import '../widgets/session_details_widget/widgets/session_details_organized_by_section_widget.dart';
import '../widgets/terms_and_conditions_bottom_sheet_widget.dart';

class SessionCheckOutScreen extends StatefulWidget {
  final CheckoutModel checkoutModel;

  const SessionCheckOutScreen({super.key, required this.checkoutModel});

  @override
  State<SessionCheckOutScreen> createState() => _SessionCheckOutScreenState();
}

class _SessionCheckOutScreenState extends State<SessionCheckOutScreen> {
  bool isDrag = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            SessionCubit()..getTrainingDetailsById(id: widget.checkoutModel.id),
        child: BlocConsumer<SessionCubit, SessionState>(
          listener: (context, state) async {
            var cubit = SessionCubit.get(context);

            if (state is GetPaymentDataSuccessState) {
              if (cubit.paymentData != null) {
                AppFunctions.logPrint(message: "Data${cubit.paymentData}");
                AppFunctions.namedNavigateTo(
                    context: context,
                    navigatedScreen: RouteConstants.payment,
                    args: WebViewDataModel(
                        training: cubit
                                .trainingDetailsResponseModel?.data?.training ??
                            Training(),
                        paymentData: cubit.paymentData ?? PaymentModel(),
                        cubit: cubit));
              }
            }
            if (state is GetPaymentDataErrorState) {
              showModalBottomSheet(
                context: context,
                builder: (context) => BottomSheetWidget(
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: FailedBottomSheetWidget(
                    error: cubit.errorMessage ??
                        AppFunctions.translateText(
                            text: AppStrings.pleaseTryAgain, context: context),
                  ),
                ),
              );
            }

            if (state is BuildPaymentSdkLoadingState ||
                state is JoinTrainingSessionLoadingState) {}
            if (state is BuildPaymentSdkErrorState) {
              showModalBottomSheet(
                context: context,
                builder: (context) => BottomSheetWidget(
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: FailedBottomSheetWidget(
                    error: cubit.errorMessage ??
                        AppFunctions.translateText(
                            text: AppStrings.pleaseTryAgain, context: context),
                  ),
                ),
              );
            }
            if (state is OpenPaymentSuccessState) {
              cubit.buildPaymentSdk(
                  context: context,
                  price: double.parse(
                    "${cubit.trainingDetailsResponseModel?.data?.training?.discountPrice != 0 ? cubit.trainingDetailsResponseModel?.data?.training?.discountPrice : cubit.trainingDetailsResponseModel?.data?.training?.price}",
                  ));
            }
            if (state is BuildPaymentSdkSuccessState) {
              await cubit
                  .joinTrainingSession(
                      state.orderId,
                      state.orderId,
                      cubit.trainingDetailsResponseModel?.data?.training ??
                          Training())
                  .then((value) {
                AppFunctions.logPrint(message: value.toString());
                if (value) {
                  AnalyticsService.logBookingSuccess(
                    sessionId: cubit.trainingDetailsResponseModel?.data?.training?.id ?? 0,
                    sessionName: cubit.trainingDetailsResponseModel?.data?.training?.name?.toString() ?? '',
                    price: double.tryParse(
                          "${cubit.trainingDetailsResponseModel?.data?.training?.discountPrice != 0 ? cubit.trainingDetailsResponseModel?.data?.training?.discountPrice : cubit.trainingDetailsResponseModel?.data?.training?.price}",
                        ) ?? 0,
                    orderId: state.orderId,
                  );
                  ReviewService.requestReviewAfterBooking();
                  AppFunctions.showSuccessDialogBox(
                      context: context,
                      child: FilledButton(
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(double.infinity, 0),
                          ),
                          onPressed: () {
                            cubit.getTrainingDetailsById(
                                id: cubit.trainingDetailsResponseModel?.data
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
                  AppFunctions.popNavigate(context: context);
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => BottomSheetWidget(
                      child: FailedBottomSheetWidget(
                        error: cubit.errorMessage ??
                            AppFunctions.translateText(
                                text: AppStrings.pleaseTryAgain,
                                context: context),
                      ),
                    ),
                  );
                }
              });
            }
          },
          builder: (context, state) {
            var cubit = SessionCubit.get(context);
            return state is BuildPaymentSdkLoadingState ||
                    state is JoinTrainingSessionLoadingState ||
                    state is GetTrainingDetailsByIdLoadingState ||
                    state is GetPaymentDataLoadingState
                ? LoadingWidget()
                : SafeArea(
                    child: Column(
                      children: [
                        HeaderWidget(
                          backOnPressed: () {
                            if (widget.checkoutModel.isPushNotification ==
                                false) {
                              if ((cubit.trainingDetailsResponseModel?.data
                                          ?.isJoined ??
                                      false) &&
                                  (widget.checkoutModel.isNotification ==
                                      false)) {
                                AppFunctions.popNavigate(context: context);
                              }
                              AppFunctions.popNavigate(context: context);
                            } else {
                              AppFunctions.namedNavigateAndFinishTo(
                                  context: context,
                                  navigatedScreen: RouteConstants.bottomNavBar);
                            }
                          },
                          title: AppStrings.checkout,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                children: [
                                  // first section of the session details (level, price , discount)
                                  SessionCheckoutDetailsWidget(
                                    training: cubit.trainingDetailsResponseModel
                                            ?.data?.training ??
                                        Training(),
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  // organization
                                  SessionDetailsOrganizedBySectionWidget(
                                    training: cubit.trainingDetailsResponseModel
                                            ?.data?.training ??
                                        Training(),
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  // summary
                                  SessionCheckoutSummaryWidget(
                                    training: cubit.trainingDetailsResponseModel
                                            ?.data?.training ??
                                        Training(),
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  // total price widget
                                  SessionCheckoutTotalWidget(
                                      training: cubit
                                              .trainingDetailsResponseModel
                                              ?.data
                                              ?.training ??
                                          Training()),
                                ],
                              ),
                            ),
                          ),
                        ),
                        cubit.trainingDetailsResponseModel?.data?.isJoined ??
                                false
                            ? SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0.w, vertical: 16.h),
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    minimumSize: const Size(double.infinity, 0),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      isDismissible: false,
                                      builder: (context) => BottomSheetWidget(
                                        title: AppStrings.terms,
                                        child:
                                            TermsAndConditionsBottomSheetWidget(
                                          cubit: cubit,
                                          price: double.parse(
                                            "${cubit.trainingDetailsResponseModel?.data?.training?.discountPrice != 0 ? cubit.trainingDetailsResponseModel?.data?.training?.discountPrice : cubit.trainingDetailsResponseModel?.data?.training?.price}",
                                          ),
                                          training: cubit
                                                  .trainingDetailsResponseModel
                                                  ?.data
                                                  ?.training ??
                                              Training(),
                                          openPayment: (bool openPayment) {
                                            AppFunctions.logPrint(
                                                message:
                                                    "Is Paymentttt: $openPayment");
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.0.h),
                                    child: CustomTextWidget(
                                        text: AppStrings.continueText,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black),
                                  ),
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
