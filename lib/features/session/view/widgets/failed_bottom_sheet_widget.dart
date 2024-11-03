import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FailedBottomSheetWidget extends StatelessWidget {
  final String error;

  const FailedBottomSheetWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              SvgPicture.asset(AppIcons.alert),
              SizedBox(
                height: 16,
              ),
              CustomTextWidget(
                text: AppStrings.somethingWrongHappened,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                textAlign: TextAlign.center,
                maxLine: 3,
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomTextWidget.server(
                text: error,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.greyColor,
                maxLine: 3,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 0),
              ),
              onPressed: () {
                AppFunctions.popNavigate(context: context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0.h),
                child: CustomTextWidget(
                  text: AppStrings.backToTraining,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              )),
        ],
      ),
    );
  }
}
