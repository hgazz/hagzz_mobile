import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/regular_with12_font_size_text/regular_with12_font_size_text.dart';
import 'package:bookit/features/profile/view/widgets/chip_widget.dart';
import 'package:bookit/features/session/view/widgets/outlined_button_widget.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SessionDetailsDateAndDescribtionSectionWidget extends StatelessWidget {
  const SessionDetailsDateAndDescribtionSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        var cubit = SessionCubit.get(context);
        var trainingDetails =
            cubit.trainingDetailsResponseModel?.data?.training;
        return Column(
          children: [
            // first section of the session details (level, date, time, location)
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ChipWidget(
                        text: trainingDetails?.level != null &&
                                trainingDetails?.level == 'All'
                            ? 'All Levels'
                            : trainingDetails?.level ?? '',
                        color: AppColors.lightOrange,
                        textColor: AppColors.black,
                        icon: AppFunctions.getLevelImage(
                            trainingDetails?.level ?? ''),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      ChipWidget(
                        text: trainingDetails?.ageGroup != null &&
                                trainingDetails?.ageGroup == 'All'
                            ? 'All Ages'
                            : trainingDetails?.ageGroup ?? '',
                        color: AppColors.lightGreen,
                        textColor: AppColors.black,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      ChipWidget(
                        text:
                            '${trainingDetails?.classes?.length} ${AppFunctions.translateText(text: AppStrings.classes, context: context)}',
                        color: AppColors.pink,
                        textColor: AppColors.black,
                        // todo : need icon from the backend
                        icon: trainingDetails?.sport?.icon,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      ChipWidget(
                        text: AppFunctions.formatDateTimeFromString(
                            date: trainingDetails?.startDate ?? ''),
                        color: Colors.transparent,
                        textColor: AppColors.black,
                        hasBorder: true,
                        height: 32,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: 15.w,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      ChipWidget(
                        text: AppFunctions.formatDateTimeFromString(
                            date: trainingDetails?.endDate ?? ''),
                        color: Colors.transparent,
                        textColor: AppColors.black,
                        hasBorder: true,
                        height: 32,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppIcons.geo,
                              height: 16.h,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Expanded(
                              child: RegularWith12FontSizeText.server(
                                  // todo: need choose the language depending on the user's localisation
                                  text: trainingDetails?.address?.address ?? '',
                                  color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                      OutlinedButtonWidget(
                          onTap: () {
                            // todo: need to long & lat from the backend to navigate
                            AppFunctions.launchCoordinates(
                                trainingDetails?.address?.latitude ?? '',
                                trainingDetails?.address?.longitude ?? '');
                          },
                          icon: AppIcons.navigate),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            // second section of the session details (description)
            Container(
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyBorderColor),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: AppStrings.description,
                        color: AppColors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      //todo: add see more/less functionality
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextWidget.server(
                          // todo : must select the language depending on the user's localisation
                          text: trainingDetails?.description ?? '',
                          color: AppColors.black,
                          textAlign: TextAlign.justify,
                          fontSize: 12.sp,
                          maxLine: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ])),
          ],
        );
      },
    );
  }
}
