import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/notifications/model/local_model/notification_permission_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              children: [
                SvgPicture.asset(AppIcons.notificationBell),
                SizedBox(height: 24.h),
                CustomTextWidget(
                  text: AppStrings.getNotified,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                SizedBox(height: 28.h),
                ...NotificationPermissionItemModel
                    .notificationPermissionItemModelList
                    .map(
                      (item) => Container(
                        padding: EdgeInsets.all(16.0.r),
                        margin: EdgeInsets.only(bottom: 8.0.r),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            CustomTextWidget.server(
                              text: item.iconText,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: CustomTextWidget(
                                text: item.description,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                SizedBox(height: 16.h),
                FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      minimumSize: const Size(double.infinity, 0),
                    ),
                    child: CustomTextWidget(
                      text: AppStrings.notifyMe,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    )),
                SizedBox(height: 8.h),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      minimumSize: const Size(double.infinity, 0),
                    ),
                    onPressed: () {},
                    child: CustomTextWidget(
                      text: AppStrings.notNow,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    )),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
