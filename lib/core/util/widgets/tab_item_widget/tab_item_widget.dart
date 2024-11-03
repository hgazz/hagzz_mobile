import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors/app_colors.dart';
import '../text_widgets/custom_text_widget.dart';

class TabItemWidget extends StatelessWidget {
  final bool isEnable;
  final String text;
  final void Function()? onTap;

  const TabItemWidget(
      {super.key,
      required this.isEnable,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: isEnable ? AppColors.black : null),
        child: Center(
          child: CustomTextWidget(
              text: text,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isEnable ? AppColors.white : AppColors.black),
        ),
      ),
    );
  }
}
