import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';
import '../../../model/training_details_response_model.dart';

class SessionCheckoutTotalWidget extends StatelessWidget {
  final Training training;

  const SessionCheckoutTotalWidget({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.surfaceContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget.server(
            text: '${AppFunctions.translateText(
              text: AppStrings.total,
              context: context,
            )}(${training?.classes?.length} ${AppFunctions.translateText(text: AppStrings.classes, context: context)})',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
          CustomTextWidget.server(
            text:
                "${training.discountPrice != 0 ? training.discountPrice : training.price} ",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }
}
