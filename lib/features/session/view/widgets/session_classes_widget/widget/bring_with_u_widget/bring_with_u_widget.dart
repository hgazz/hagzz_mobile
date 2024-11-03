import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';

class BringWithUWidget extends StatelessWidget {
  final List<String> bringWithU;

  const BringWithUWidget({super.key, required this.bringWithU});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: AppStrings.bringWithYou,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
          SizedBox(
            height: 8.h,
          ),
          for (var i = 0; i < bringWithU.length; i++) ...[
            CustomTextWidget.server(
              text: bringWithU[i],
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            )
          ]
        ],
      ),
    );
  }
}
