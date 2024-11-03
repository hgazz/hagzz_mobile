import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/notifications/model/enum_model/enum_details_models.dart';
import 'package:bookit/features/notifications/view/widgets/page_view_widget/page_view_widget.dart';
import 'package:bookit/features/notifications/view/widgets/selected_tab_notification_widget.dart';
import 'package:bookit/features/notifications/view_model/notification_cubit.dart';
import 'package:bookit/features/profile/view/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    NotificationCubit.get(context).page = 1;
    NotificationCubit.get(context).notificationsModel = null;
    NotificationCubit.get(context).currentNotificationTab =
        NotificationTabs.present;
    NotificationCubit.get(context).getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(
              backOnPressed: () {
                NotificationCubit.get(context).page = 1;
                NotificationCubit.get(context).notificationsModel = null;
                NotificationCubit.get(context).currentNotificationTab =
                    NotificationTabs.present;

                Navigator.pop(context);
              },
              title: AppStrings.notifications,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
              child: Row(
                children: [
                  CustomTextWidget(
                      text: AppStrings.youHave,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor),
                  BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      var cubit = NotificationCubit.get(context);

                      return CustomTextWidget.server(
                        text:
                            ' ${cubit.currentNotificationTab == NotificationTabs.present ? "${(cubit.notificationsModel?.data?.newNotifications?.length ?? 0)}" : cubit.notificationsModel?.data?.pastNotifications?.length} ',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.greyColor,
                      );
                    },
                  ),
                  CustomTextWidget(
                    text: AppStrings.newNotifications,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.greyColor,
                  ),
                ],
              ),
            ),
            const SelectedTabNotificationWidget(),
            SizedBox(height: 16.h),
            NotificationPageViewWidget(),
            // NotificationListWidget(),
          ],
        ),
      ),
    );
  }
}
