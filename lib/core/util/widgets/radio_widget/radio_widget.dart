import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/widgets/text_widgets/hint_text_widget/hint_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  final bool isSelected;
  final bool isValidationError;

  const RadioWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.onTap,
      required this.isSelected,
      this.isValidationError = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 56.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48.r),
              border: Border.all(
                  color: !isValidationError
                      ? isSelected
                          ? AppColors.black
                          : AppColors.lightGreyColor
                      : AppColors.redColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: isSelected ? AppColors.black : AppColors.lightGreyColor,
              ),
              SizedBox(
                width: 8.w,
              ),
              HintTextWidget(
                  text: text,
                  color:
                      isSelected ? AppColors.black : AppColors.lightGreyColor)
            ],
          ),
        ),
      ),
    );
  }
}
