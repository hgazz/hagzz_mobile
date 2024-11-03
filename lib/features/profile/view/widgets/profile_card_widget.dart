import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileCardWidget extends StatelessWidget {
  final String title;
  final String icon;
  final String navigatedScreen;

  const ProfileCardWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.navigatedScreen});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () {
          AppFunctions.namedNavigateTo(
              context: context, navigatedScreen: navigatedScreen);
        },
        child: Container(
          height: 89.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(icon),
                  SvgPicture.asset(AppIcons.goArrow),
                ],
              ),
              CustomTextWidget(
                text: title,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
