import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget? trailing;

  const ProfileMenuItemWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.trailing,
      this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
      minVerticalPadding: 16,
      leading: SvgPicture.asset(
        icon,
        width: 24.w,
        height: 24.h,
      ),
      title: CustomTextWidget(
        text: title,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: title == AppStrings.signOut || title == AppStrings.deleteAccount
            ? AppColors.orangeRedColor
            : AppColors.black,
      ),
      trailing: trailing,
    );
  }
}
