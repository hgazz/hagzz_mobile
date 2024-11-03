import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';

class DepartmentsHeaderRowWidget extends StatelessWidget {
  final String firstText;
  final String lastText;
  final void Function()? onTap;
  final int? trainingsCount;

  const DepartmentsHeaderRowWidget(
      {super.key,
      required this.firstText,
      required this.lastText,
      required this.onTap,
      this.trainingsCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomTextWidget(
                text: firstText,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.black),
            SizedBox(
              width: 4.w,
            ),
            if (trainingsCount != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.r),
                    color: AppColors.surfaceContainer,
                    border: Border.all(color: AppColors.outlineVariant)),
                child: Center(
                  child: CustomTextWidget.server(
                      text: trainingsCount.toString(),
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                      color: AppColors.black),
                ),
              )
          ],
        ),
        InkWell(
          onTap: onTap,
          child: CustomTextWidget(
              text: lastText,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.black),
        ),
      ],
    );
  }
}
