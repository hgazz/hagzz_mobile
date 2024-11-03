import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemoveItemValidationWidget extends StatelessWidget {
  final void Function() onPressed;

  const RemoveItemValidationWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          CustomTextWidget(
            text: AppStrings.removeItemValidationMessage,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.greyColor,
            maxLine: 3,
          ),
          SizedBox(
            height: 32.h,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: CustomTextWidget(
                      text: AppStrings.buttonNoKeepIt,
                      color: AppColors.black,
                      fontSize: 16.sp,
                      maxLine: 2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.lemonColor,
                  ),
                  onPressed: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: CustomTextWidget(
                      text: AppStrings.buttonYesRemoveIt,
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
