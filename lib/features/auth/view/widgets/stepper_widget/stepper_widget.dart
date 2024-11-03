import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';

class StepperWidget extends StatelessWidget {
  final bool isSelected;

  const StepperWidget({super.key,
  required this.isSelected,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: isSelected?AppColors.lemonColor:AppColors.greyWithOpacityColor,
      ),
    );
  }
}
