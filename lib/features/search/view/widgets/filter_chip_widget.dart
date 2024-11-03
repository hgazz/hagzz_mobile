import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterChipWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function() onTap;

  const FilterChipWidget(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const StadiumBorder(),
      onTap: onTap,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: ShapeDecoration(
          color: isSelected ? AppColors.black : AppColors.surfaceContainer,
          shape: const StadiumBorder(),
        ),
        child: CustomTextWidget(
          text: text,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: isSelected ? AppColors.white : AppColors.black,
        ),
      ),
    );
  }
}
