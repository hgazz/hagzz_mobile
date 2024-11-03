import 'package:bookit/features/session/model/training_details_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';

class SessionCheckoutSummaryWidget extends StatelessWidget {
  final Training training;

  const SessionCheckoutSummaryWidget({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
            text: AppStrings.bookingSummary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black),
        SizedBox(
          height: 8.h,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: ExpansionTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            collapsedBackgroundColor: AppColors.surfaceContainer,
            backgroundColor: AppColors.surfaceContainer,
            iconColor: AppColors.black,
            title: CustomTextWidget.server(
              text: training?.name ?? '',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
              isServer: true,
            ),
            subtitle: CustomTextWidget.server(
              text: (training?.classes?.length ?? 0) > 0
                  ? '${training?.classes?.length} ${AppFunctions.translateText(text: AppStrings.classes, context: context)}'
                  : '${training?.classes?.length} ${AppFunctions.translateText(text: AppStrings.classes, context: context)}',
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
            children: List.generate(
              training?.classes?.length ?? 0,
              (index) => Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextWidget.server(
                        text: AppFunctions
                            .formatDateTimeFromStringForSessionDetails(
                                date: training.classes?[index].date ?? ''),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                        isServer: true,
                        maxLine: 3,
                      ),
                    ),
                    Expanded(
                      child: CustomTextWidget.server(
                        text: (training.classes![index].startTime != null
                                ? AppFunctions.convertTimeFormat(
                                    training.classes?[index].startTime ?? '')
                                : '') +
                            ' - ' +
                            (training.classes![index].endTime != null
                                ? AppFunctions.convertTimeFormat(
                                    training.classes?[index].endTime ?? '')
                                : ''),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                        isServer: true,
                        maxLine: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
