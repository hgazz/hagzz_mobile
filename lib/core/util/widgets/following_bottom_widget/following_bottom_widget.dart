import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../constants/app_colors/app_colors.dart';
import '../text_widgets/medium_text_widget/medium_text_widget.dart';

class FollowingBottomWidget extends StatelessWidget {
  final bool isFollowing;
  final void Function()? onTap;
  final Color? backgroundColor;

  const FollowingBottomWidget(
      {super.key,
      required this.isFollowing,
      required this.onTap,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              minimumSize: Size(double.infinity, 48.h),
              elevation: 0,
              shadowColor: Colors.transparent,
              disabledForegroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  side: isFollowing
                      ? const BorderSide(color: AppColors.black)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(30.r))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isFollowing ? Symbols.done_rounded : Symbols.add_rounded,
                color: AppColors.black,
              ),
              SizedBox(
                width: 5.w,
              ),
              MediumTextWidget(
                text: isFollowing ? AppStrings.following : AppStrings.follow,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          )),
    );
  }
}
