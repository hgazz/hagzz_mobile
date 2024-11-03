import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArrowContainerWidget extends StatelessWidget {
  final void Function()? onTap;
  final Color backgroundColor;
  final bool isLeft;

  const ArrowContainerWidget(
      {super.key,
      required this.onTap,
      required this.backgroundColor,
      required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
        child: Icon(
          isLeft ? Icons.arrow_back_rounded : Icons.arrow_forward_outlined,
          color: backgroundColor == AppColors.classesIndexDisabled
              ? AppColors.disableColor
              : AppColors.black,
        ),
      ),
    );
  }
}
