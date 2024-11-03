import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors/app_colors.dart';

class ContainerIconWidget extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;

  const ContainerIconWidget(
      {super.key, required this.icon, required this.onTap, this.margin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12.r)),
        child: Icon(
          icon,
          size: 20.w,
          color: Colors.black,
        ),
      ),
    );
  }
}
