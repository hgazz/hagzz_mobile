import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_images/app_images.dart';
import 'package:bookit/core/util/widgets/circle_image_widget/circle_image_widget.dart';
import 'package:bookit/core/util/widgets/container_with_circle_shape_with_white_background_color_widget/container_with_circle_shape_with_white_background_color_widget.dart';
import 'package:bookit/core/util/widgets/following_and_notifications_bottom_widget/model/type_data.dart';
import 'package:bookit/core/util/widgets/following_and_notifications_bottom_widget/view/following_and_notifications_bottom_widget.dart';
import 'package:bookit/core/util/widgets/statistic_data_widget/statistic_data_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/text_with_font_size_12_and_w500_weight_grey_color_widget/text_with_font_size_12_and_w500_weight_grey_color_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';
import 'package:bookit/features/academy_profile/model/local_models/statistics_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_icons/app_icons.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/row_contain_icon_and_text_widget/row_contain_icon_and_text_widget.dart';

class AcademyDataWidget extends StatelessWidget {
  final StatisticsModel? data;

  const AcademyDataWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    AppFunctions.logPrint(message: "imageee: ${data?.image}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            data?.image != ""
                ? CircleImageWidget(image: data?.image ?? "")
                : ContainerWithCircleShapeWithWhiteBackgroundColorWidget(
                    image: AppImages.defaultAcademyImage,
                    isDetails: true,
                  ),
            SizedBox(
              width: 32.w,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatisticDataWidget(
                      number: data?.numberOfCoaches, text: AppStrings.coaches),
                  StatisticDataWidget(
                      number: data?.numberOfTrainers,
                      text: AppStrings.training),
                  StatisticDataWidget(
                      number: data?.numberOfLocations,
                      text: AppStrings.locations),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            Expanded(
                child: TitleTextWidget.server(
              text: data?.name,
              maxLines: 2,
            )),
            SizedBox(
              width: 10.w,
            ),
            RowContainIconAndTextWidget(
                icon: data != null ? AppIcons.persons : null,
                text: data?.followers.toString()),
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        TextWithFontSize12AndW500WeightGreyColorWidget.server(
            text: data?.specialization),
        SizedBox(
          height: 16.h,
        ),
        FollowingAndNotificationsBottomWidget(
          data: data != null
              ? TypeData(
                  id: data?.id ?? 0,
                  type: "academy",
                  isFollow: data?.isFollow ?? false)
              : null,
        )
      ],
    );
  }
}
