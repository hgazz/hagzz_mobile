import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:bookit/core/util/widgets/tab_item_widget/tab_item_widget.dart';
import 'package:bookit/features/notifications/model/enum_model/enum_details_models.dart';
import 'package:bookit/features/notifications/view_model/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedTabNotificationWidget extends StatelessWidget {
  const SelectedTabNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        var cubit = NotificationCubit.get(context);
        return cubit.notificationsModel != null
            ? Container(
                width: 229.w,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  color: AppColors.surfaceContainer,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TabItemWidget(
                        onTap: () {
                          cubit.changeDetailsCategory(
                              category: NotificationTabs.present);
                        },
                        text: AppStrings.present,
                        isEnable: cubit.currentNotificationTab ==
                            NotificationTabs.present,
                      ),
                    ),
                    Expanded(
                      child: TabItemWidget(
                        onTap: () {
                          cubit.changeDetailsCategory(
                              category: NotificationTabs.past);
                        },
                        text: AppStrings.past,
                        isEnable: cubit.currentNotificationTab ==
                            NotificationTabs.past,
                      ),
                    ),
                  ],
                ),
              )
            : ShimmerWidget(width: 229.w, height: 40.h);
      },
    );
  }
}
