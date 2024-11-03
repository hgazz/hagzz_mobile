import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final Function() onTap;
  final String icon;
  final double? width;
  final double? height;
  final double iconWidth;
  final double iconHeight;
  final BoxFit fit;
  final double padding;
  final Color borderColor;

  const OutlinedButtonWidget({
    super.key,
    required this.onTap,
    required this.icon,
    this.width,
    this.height,
    this.iconWidth = 24,
    this.iconHeight = 24,
    this.fit = BoxFit.contain,
    this.padding = 8,
    this.borderColor = AppColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
          width: width?.w,
          height: height?.h,
          padding: EdgeInsets.all(padding.r),
          decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(16.r)),
          child: SvgPicture.asset(
            icon,
            width: iconWidth.w,
            height: iconHeight.h,
            fit: fit,
          )),
    );
  }
}
