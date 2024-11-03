import 'package:bookit/core/util/constants/app_bottom_sheets/app_bottom_sheets.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/widgets/svg_image_widget/svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleNotificationIconWidget extends StatelessWidget {
  const CircleNotificationIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppBottomSheet.notificationsBottomSheet(context: context);
      },
      child: Container(
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: AppColors.black)),
        child: const SVGImageWidget(image: AppIcons.editNotificationsIcon),
      ),
    );
  }
}
