import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/session/model/training_details_response_model.dart';
import 'package:bookit/features/session/view/widgets/choose_payment_bottom_sheet_widget/choose_payment_bottom_sheet_widget.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsBottomSheetWidget extends StatelessWidget {
  final double price;
  final Training training;
  final void Function(bool openPayment) openPayment;
  final SessionCubit cubit;

  const TermsAndConditionsBottomSheetWidget(
      {super.key,
      required this.price,
      required this.training,
      required this.openPayment,
      required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  padding: EdgeInsets.all(16.r),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.greyWithOpacityColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: AppStrings.paymentAndCollection,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomTextWidget(
                        text: AppStrings.paymentAndCollectionParagraph,
                        fontSize: 14.sp,
                        maxLine: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: EdgeInsets.all(16.r),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.greyWithOpacityColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: AppStrings.bookingCancellation,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomTextWidget(
                        text: AppStrings.bookingCancellationParagraph,
                        fontSize: 14.sp,
                        maxLine: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: EdgeInsets.all(16.r),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.greyWithOpacityColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: AppStrings.Refunds,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomTextWidget(
                        text: AppStrings.RefundsParagraph,
                        fontSize: 14.sp,
                        maxLine: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 0),
              ),
              onPressed: () async {
                // cubit.getPayment(
                //     id: cubit
                //             .trainingDetailsResponseModel?.data?.training?.id ??
                //         0);
                AppFunctions.popNavigate(context: context);
                AppFunctions.showBottomSheet(
                    context: context,
                    child: ChoosePaymentBottomSheetWidget(cubit: cubit));
                // try {
                // } catch (e, st) {
                //   debugPrint("OrderApiResponse Error: $e \n $st");
                //
                //   // An unexpected error due to improper SDK
                //   // integration or Plugin internal bug
                // }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0.h),
                child: CustomTextWidget(
                    text: AppStrings.goToPayment,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
              ))
        ],
      ),
    );
  }
}
