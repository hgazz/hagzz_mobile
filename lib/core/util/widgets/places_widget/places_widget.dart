import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/models/local_models/details_data_model/details_data_model.dart';
import 'package:bookit/core/util/widgets/circle_image_widget/circle_image_widget.dart';
import 'package:bookit/core/util/widgets/row_contain_icon_and_text_widget/row_contain_icon_and_text_widget.dart';
import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/local_models/place_coach_model/place_coach_model.dart';
import '../text_widgets/title_text_widget/title_text_widget.dart';

class PlacesWidget extends StatelessWidget {
  final PlaceCoachModel? data;
  final bool isVertical;

  const PlacesWidget({super.key, required this.data, required this.isVertical});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (data?.following != null) {
          AppFunctions.namedNavigateTo(
              context: context,
              navigatedScreen: RouteConstants.academyProfile,
              args:
                  DetailsDataModel(id: data?.id ?? 0, name: data?.name ?? ""));
        }
        if (data?.rate != null) {
          // TODO:navigate to coach profile screen

          AppFunctions.namedNavigateTo(
              context: context,
              navigatedScreen: RouteConstants.coachProfile,
              args:
                  DetailsDataModel(id: data?.id ?? 0, name: data?.name ?? ""));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.surfaceContainer,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: data != null
                  ? CircleImageWidget(
                      image: data?.image ?? '',
                      imageFit: data?.following == null ? BoxFit.cover : null,
                    )
                  : ShimmerWidget(
                      width: 40.w,
                      height: 40.h,
                      containerShape: BoxShape.circle,
                    ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    data != null
                        ? isVertical
                            ? Row(
                                children: [
                                  Expanded(
                                    child: TitleTextWidget.server(
                                        text: data?.name ?? ''),
                                  ),
                                  if (data?.rate != null) ...[
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    SvgPicture.asset(
                                      AppIcons.verify,
                                      width: 16.w,
                                    ),
                                  ]
                                ],
                              )
                            : Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TitleTextWidget.server(
                                          text: data?.name ?? ''),
                                    ),
                                    if (data?.rate != null) ...[
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      SvgPicture.asset(
                                        AppIcons.verify,
                                        width: 16.w,
                                      ),
                                    ]
                                  ],
                                ))
                        : ShimmerWidget(width: 100.w, height: 20.w),
                    data != null
                        ? isVertical
                            ? RowContainIconAndTextWidget(
                                icon: data?.following != null
                                    ? AppIcons.persons
                                    : AppIcons.rate,
                                text: data?.following ?? data?.rate ?? '')
                            : Expanded(
                                child: RowContainIconAndTextWidget(
                                    icon: data?.following != null
                                        ? AppIcons.persons
                                        : AppIcons.rate,
                                    text: data?.following ?? data?.rate ?? ''))
                        : ShimmerWidget(width: 100.w, height: 20.w),
                    SizedBox(
                      height: 2.h,
                    ),
                    data != null
                        ? CustomTextWidget.server(
                            text: data?.department ?? '',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor,
                          )
                        : ShimmerWidget(width: 100.w, height: 20.w)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
