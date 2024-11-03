import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/label_text_widget/label_text_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/share_or_report_item_widget/share_or_report_item_widget.dart';
import '../../widgets/text_widgets/custom_text_widget.dart';

class AppBottomSheet {
  static notificationsBottomSheet({required context}) =>
      AppFunctions.showBottomSheet(
          context: context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TitleTextWidget(text: AppStrings.notifications),
              SizedBox(
                height: 10.h,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => Row(
                  children: [
                    const Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleTextWidget.server(text: "New Training Sessions"),
                        LabelTextWidget.server(
                            text:
                                "Get notified when new relevant training sessions are available.")
                      ],
                    )),
                    Switch(
                        value: true,
                        onChanged: (value) {},
                        activeThumbImage: Image.asset(
                          AppIcons.active,
                        ).image,
                        activeTrackColor: AppColors.lemonColor)
                  ],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 4.h,
                ),
                itemCount: 2,
              )
            ],
          ));

  static moreProfileIconBottomSheet({required context}) =>
      AppFunctions.showBottomSheet(
          context: context,
          child: Column(
            children: [
              CustomTextWidget(
                text: AppStrings.actions,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ShareOrReportItemWidget(
                    isShare: true,
                  ),
                ],
              ),
            ],
          ));

  static sendCodeVia({required context, required Widget widget}) =>
      AppFunctions.showBottomSheet(context: context, child: widget);
}
