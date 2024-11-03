import 'package:bookit/features/session/model/training_details_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';
import '../../../../profile/view/widgets/chip_widget.dart';

class SessionCheckoutDetailsWidget extends StatelessWidget {
  final Training training;

  const SessionCheckoutDetailsWidget({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.borderColor,
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.r),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                    text: training?.name ?? '',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    ChipWidget(
                      text: training?.level != null && training?.level == 'All'
                          ? 'All Levels'
                          : training?.level ?? '',
                      color: AppColors.lightOrange,
                      textColor: AppColors.black,
                      icon: AppFunctions.getLevelImage(training?.level ?? ''),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    ChipWidget(
                      text: training?.ageGroup != null &&
                              training?.ageGroup == 'All'
                          ? 'All Ages'
                          : training?.ageGroup ?? '',
                      color: AppColors.lightGreen,
                      textColor: AppColors.black,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    ChipWidget(
                      text:
                          '${training?.classes?.length} ${AppFunctions.translateText(text: AppStrings.classes, context: context)}',
                      color: AppColors.pink,
                      textColor: AppColors.black,
                      // todo : need icon from the backend
                      icon: training?.sport?.icon,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomTextWidget.server(
                        text:
                            " ${training?.discountPrice != 0 ? training?.discountPrice : training?.price.toString() ?? ''}",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                    SizedBox(
                      width: 4.w,
                    ),
                    training?.discountPrice != 0
                        ? Text(
                            training?.price?.toString() ?? '',
                            style: GoogleFonts.inter(
                                color: AppColors.greyColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough),
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      width: 2.w,
                    ),
                    training.discountPrice != 0
                        ? Text(
                            "${((((training.price ?? 0) - (training.discountPrice ?? 0)) / (training.price ?? 0)) * 100).round()}%",
                            style: GoogleFonts.inter(
                              color: AppColors.greenColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                training?.discountPrice != 0
                    ? Text(
                        AppFunctions.translateText(
                            text: AppStrings.limitedTime, context: context),
                        style: GoogleFonts.inter(
                          color: AppColors.orangeRedColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
