import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/models/api_models/training_model/training_model.dart';
import 'package:bookit/core/util/widgets/save_icon_widget/view/save_icon_widget.dart';
import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/regular_with12_font_size_text/regular_with12_font_size_text.dart';
import 'package:bookit/core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';
import 'package:bookit/features/profile/view/widgets/chip_widget.dart';
import 'package:bookit/features/session/model/local_model/session_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TrainingCardWidget extends StatefulWidget {
  final bool isVertical;
  final bool isPast;
  final TrainingModel? trainingItem;
  final int? index;

  const TrainingCardWidget(
      {super.key,
      required this.isVertical,
      required this.isPast,
      required this.trainingItem,
      this.index});

  @override
  State<TrainingCardWidget> createState() => _TrainingCardWidgetState();
}

class _TrainingCardWidgetState extends State<TrainingCardWidget> {
  String? startDate;

  String? endDate;

  formatDate() {
    DateTime sDate = DateTime.parse(widget.trainingItem?.startDate ?? '');
    DateTime eDate = DateTime.parse(widget.trainingItem?.endDate ?? '');
    startDate = DateFormat('E,d MMM', CachedVariables.lang).format(sDate);
    endDate = DateFormat('E,d MMM', CachedVariables.lang).format(eDate);
  }

  int detectHappenedTime() {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime.parse(widget.trainingItem?.startDate ?? '');

    return startDate.compareTo(now);
  }

  @override
  void initState() {
    if (widget.trainingItem != null) {
      formatDate();
      detectHappenedTime();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.35),
      onTap: () async {
        // SessionCubit.get(context)
        //     .getTrainingDetailsById(id: widget.trainingItem?.id ?? 0)
        //     .then((value) {
        //   if (SessionCubit.get(context)
        //           .trainingDetailsResponseModel
        //           ?.data
        //           ?.training
        //           ?.id !=
        //       null) {
        //
        //   }
        // });
        AppFunctions.namedNavigateTo(
            context: context,
            navigatedScreen: RouteConstants.sessions,
            args: SessionLocalModel(sessionId: widget.trainingItem?.id ?? 0));
      },
      child: Container(
        width:
            widget.isVertical ? null : MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(8),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFCECECE)),
            borderRadius: BorderRadius.circular(20.35),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //todo add condition for happening in 2d 3h
            if (widget.trainingItem != null)
              if (detectHappenedTime() > 0) ...[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: RegularWith12FontSizeText.server(
                    text: '${AppStrings.happenIn} ${detectHappenedTime()}d',
                    color: AppColors.orangeRedColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            if (widget.trainingItem == null)
              ShimmerWidget(width: 40.w, height: 40.h),
            // isVertical
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: ShapeDecoration(
                color: AppColors.whiteSurfaceContainer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          widget.trainingItem != null
                              ? RegularWith12FontSizeText.server(
                                  text: widget.trainingItem?.academy
                                          ?.commercialName ??
                                      '',
                                  color: AppColors.black,
                                )
                              : ShimmerWidget(width: 20.w, height: 20.h),
                          SizedBox(
                            width: 8.w,
                          ),
                          widget.trainingItem != null
                              ? SvgPicture.asset(AppIcons.followers)
                              : ShimmerWidget(width: 20.w, height: 20.h),
                          SizedBox(
                            width: 4.w,
                          ),
                          widget.trainingItem != null
                              ? RegularWith12FontSizeText.server(
                                  // todo get followers from trainingItem from api
                                  text:
                                      "${widget.trainingItem?.academy?.followsCount ?? "0"}",
                                  color: AppColors.greyColor,
                                )
                              : ShimmerWidget(width: 20.w, height: 20.h),
                        ],
                      ),
                      widget.trainingItem != null
                          ? SaveIconWidget(
                              id: widget.trainingItem?.id ?? 0,
                              isSaved: widget.trainingItem?.isSaved ?? false,
                              index: widget.index,
                              getSaveValue: (value) {},
                            )
                          : ShimmerWidget(
                              width: 50.w,
                              height: 20.w,
                              containerShape: BoxShape.circle,
                            )
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  widget.trainingItem != null
                      ? TitleTextWidget.server(
                          text: widget.trainingItem?.name ?? '',
                        )
                      : ShimmerWidget(width: 20.w, height: 20.h),

                  SizedBox(
                    height: 4.h,
                  ),
                  widget.trainingItem != null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppIcons.location),
                            SizedBox(
                              width: 4.w,
                            ),
                            Expanded(
                              child: RegularWith12FontSizeText.server(
                                text: widget.trainingItem?.address.toString() ??
                                    '',
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        )
                      : ShimmerWidget(width: 50.w, height: 20.w),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      ChipWidget(
                        text: startDate,
                        color: AppColors.whiteColor,
                        textColor: AppColors.black,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      widget.trainingItem != null
                          ? Icon(
                              Icons.arrow_forward_outlined,
                              size: 15.w,
                            )
                          : ShimmerWidget(width: 20.w, height: 20.h),
                      SizedBox(
                        width: 2.w,
                      ),
                      ChipWidget(
                        text: endDate,
                        color: AppColors.whiteColor,
                        textColor: AppColors.black,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  // todo get chips from trainingItem from api
                  Row(
                    children: [
                      ChipWidget(
                        text: widget.trainingItem?.level,
                        color: AppColors.lightOrange,
                        textColor: AppColors.black,
                        icon: AppFunctions.getLevelImage(
                            widget.trainingItem?.level ?? ''),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      ChipWidget(
                        text: widget.trainingItem?.ageGroup == "All"
                            ? 'All Ages'
                            : widget.trainingItem?.ageGroup,
                        color: AppColors.lightGreen,
                        textColor: AppColors.black,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      ChipWidget(
                        text: widget.trainingItem != null
                            ? '${widget.trainingItem?.classesCount} ${AppFunctions.translateText(text: AppStrings.classes, context: context)}'
                            : null,
                        color: AppColors.pink,
                        textColor: AppColors.black,
                        icon: widget.trainingItem?.sportIcon,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!widget.isPast) ...[
              const SizedBox(
                height: 2,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.trainingItem != null
                              ? Row(
                                  children: [
                                    CustomTextWidget.server(
                                        text:
                                            " ${(widget.trainingItem?.discount != null && widget.trainingItem?.discount != 0) ? widget.trainingItem?.discount : widget.trainingItem?.price.toString() ?? ''}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    (widget.trainingItem?.discount != null &&
                                            widget.trainingItem?.discount != 0)
                                        ? Text(
                                            widget.trainingItem?.price
                                                    ?.toString() ??
                                                '',
                                            style: GoogleFonts.inter(
                                                color: AppColors.greyColor,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          )
                                        : SizedBox.shrink(),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    (widget.trainingItem?.discount != null &&
                                            widget.trainingItem?.discount != 0)
                                        ? Text(
                                            "${((((widget.trainingItem?.price ?? 0) - (widget.trainingItem?.discount ?? 0)) / (widget.trainingItem?.price ?? 0)) * 100).round()}%",
                                            style: GoogleFonts.inter(
                                              color: AppColors.greenColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                )
                              : ShimmerWidget(width: 50.w, height: 20.w),
                          SizedBox(
                            height: 4.h,
                          ),
                          widget.trainingItem != null
                              ? (widget.trainingItem?.discount != 0 &&
                                      widget.trainingItem?.discount != null)
                                  ? Text(
                                      AppFunctions.translateText(
                                          text: AppStrings.limitedTime,
                                          context: context),
                                      style: GoogleFonts.inter(
                                        color: AppColors.orangeRedColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : SizedBox.shrink()
                              : ShimmerWidget(width: 50.w, height: 20.w),
                          SizedBox(
                            height: 4.h,
                          ),
                        ],
                      ),
                    ),
                    widget.trainingItem != null
                        ? Container(
                            height: 32.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: AppColors.black),
                            child: CustomTextWidget.server(
                              text:
                                  '${widget.trainingItem?.joinsCount}/${widget.trainingItem?.maxPlayers} ${AppFunctions.translateText(text: AppStrings.students, context: context)}',
                              color: AppColors.whiteColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : ShimmerWidget(width: 80.w, height: 30.h)
                  ],
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
