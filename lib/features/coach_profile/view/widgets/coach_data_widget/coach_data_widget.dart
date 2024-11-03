import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/core/util/widgets/circle_image_widget/circle_image_widget.dart';
import 'package:bookit/core/util/widgets/following_and_notifications_bottom_widget/model/type_data.dart';
import 'package:bookit/core/util/widgets/following_and_notifications_bottom_widget/view/following_and_notifications_bottom_widget.dart';
import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:bookit/core/util/widgets/statistic_data_widget/statistic_data_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/text_with_font_size_12_and_w500_weight_grey_color_widget/text_with_font_size_12_and_w500_weight_grey_color_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';
import 'package:bookit/features/coach_profile/view_model/coach_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_images/app_images.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/container_with_circle_shape_with_white_background_color_widget/container_with_circle_shape_with_white_background_color_widget.dart';

class CoachDataWidget extends StatelessWidget {
  const CoachDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoachProfileCubit, CoachProfileState>(
      builder: (context, state) {
        var cubit = CoachProfileCubit.get(context);
        var data = cubit.coachDetails?.data?.coach;
        return AnimatedConditionalBuilder(
            condition: cubit.coachDetails != null,
            builder: (context) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        data?.image != ""
                            ? CircleImageWidget(
                                image: data?.image ?? '',
                                imageFit: BoxFit.contain,
                              )
                            : ContainerWithCircleShapeWithWhiteBackgroundColorWidget(
                                image: AppImages.defaultCoachImage,
                                isDetails: true),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //TODO : Edit From Backend to get that data
                                StatisticDataWidget(
                                    number: data?.traineesCount ?? 0,
                                    text: AppStrings.trainees),
                                StatisticDataWidget(
                                    number: data?.trainingsCount ?? 0,
                                    text: AppStrings.sessions),
                                StatisticDataWidget(
                                    number: data?.totalHours ?? 0,
                                    text: AppStrings.hours),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TitleTextWidget.server(
                        text: cubit.coachDetails?.data?.coach?.name ?? ''),
                    SizedBox(
                      height: 5.h,
                    ),
                    data?.license != ""
                        ? Row(
                            children: [
                              const Icon(
                                Icons.verified_rounded,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              TextWithFontSize12AndW500WeightGreyColorWidget
                                  .server(text: data?.license ?? ''),
                              SizedBox(
                                width: 4.w,
                              ),
                              TextWithFontSize12AndW500WeightGreyColorWidget
                                  .server(text: "(${data?.licenseType ?? ''})"),
                            ],
                          )
                        : const SizedBox.shrink(),
                    SizedBox(
                      height: 4.h,
                    ),
                    TextWithFontSize12AndW500WeightGreyColorWidget.server(
                        text: data?.description ?? ''),
                    SizedBox(
                      height: 10.h,
                    ),
                    FollowingAndNotificationsBottomWidget(
                      data: TypeData(
                          id: data?.id ?? 0,
                          type: "coach",
                          isFollow:
                              cubit.coachDetails?.data?.isFollow ?? false),
                    )
                  ],
                ),
            fallback: (context) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ShimmerWidget(width: 50.w, height: 50.h),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //TODO : Edit From Backend to get that data
                                StatisticDataWidget(
                                    number: data?.academy?.trainingsCount,
                                    text: AppStrings.trainees),
                                StatisticDataWidget(
                                    number: data?.academy?.trainingsCount,
                                    text: AppStrings.sessions),
                                StatisticDataWidget(
                                  number: null,
                                  text: null,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TitleTextWidget.server(
                        text: cubit.coachDetails?.data?.coach?.name),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        ShimmerWidget(width: 20.h, height: 20.h),
                        SizedBox(
                          width: 6.w,
                        ),
                        TextWithFontSize12AndW500WeightGreyColorWidget.server(
                            text: data?.license),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    TextWithFontSize12AndW500WeightGreyColorWidget.server(
                        text: data?.description),
                    SizedBox(
                      height: 10.h,
                    ),
                    FollowingAndNotificationsBottomWidget(
                      data: null,
                    )
                  ],
                ));
      },
    );
  }
}
