import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors/app_colors.dart';
import '../text_widgets/custom_text_widget.dart';

class OutLineIconBottomWidget extends StatelessWidget {
  final void Function() onTap;
  final Widget? icon;
  final String text;

  const OutLineIconBottomWidget(
      {super.key, required this.onTap, this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: icon != null
            ? EdgeInsets.only(right: 12.w, left: 16.w, top: 5.h, bottom: 5.h)
            : EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.greyBorderColor,
            )),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextWidget(
              text: text,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
            if (icon != null) ...[
              SizedBox(
                width: 4.w,
              ),
              icon!,
            ],
          ],
        ),
      ),
    );
    // return OutlinedButton.icon(
    //     style: OutlinedButton.styleFrom(
    //       side: const BorderSide(
    //         color: AppColors.greyBorderColor,
    //       ),
    //     ),
    //     onPressed: onTap,
    //     icon: icon,
    //     label: CustomTextWidget(
    //       text: text,
    //       fontSize: 12.sp,
    //       fontWeight: FontWeight.w400,
    //       color: AppColors.black,
    //     ));
  }
}
