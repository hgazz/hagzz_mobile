import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_images/app_images.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/profile/view/widgets/chip_widget.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class SessionDetailsJoinedSectionWidget extends StatelessWidget {
  const SessionDetailsJoinedSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        var cubit = SessionCubit.get(context);
        var trainingDetails =
            cubit.trainingDetailsResponseModel?.data?.training;
        //todo : need joined players list and count from the backend
        var isCompleted = false;
        // var isCompleted = trainingDetails?.maxPlayers == 0 ||
        //     trainingDetails?.maxPlayers == trainingDetails?.joinedPlayers;
        var joinedPlayers = cubit.trainingDetailsResponseModel?.data?.joins;
        AppFunctions.logPrint(message: "Joinsssssssssssss: ${joinedPlayers}");
        num joinedCount = trainingDetails?.joinsCount ?? 0;

        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: AppStrings.joined,
                        color: AppColors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      ChipWidget(
                          // todo : need to get the count of joined players from the backend
                          text:
                              '${joinedCount}/${trainingDetails?.maxPlayers ?? 0}',
                          color: AppColors.black,
                          textColor: AppColors.white)
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 28.h,
                    child: joinedPlayers?.isEmpty ?? false
                        // todo : need to get the list of joined players from the backend
                        // trainingDetails?.joinedPlayers == 0
                        ? Center(
                            child: CustomTextWidget(
                              text: AppStrings.noOneJoined,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          )
                        : SizedBox(
                            height: 30.h,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                SizedBox(
                                  height: 30.h,
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate(
                                        joinedPlayers?.length ?? 0,
                                        (index) => CachedNetworkImage(
                                              imageUrl:
                                                  joinedPlayers?[index].image ??
                                                      '',
                                              fit: BoxFit.contain,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      CircleAvatar(
                                                radius: 14.r,
                                                backgroundImage: imageProvider,
                                              ),
                                              placeholder: (context, image) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.grey.shade400,
                                                highlightColor: Colors.grey,
                                                child: CircleAvatar(
                                                  radius: 14.r,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, text, obj) =>
                                                      CircleAvatar(
                                                radius: 14.r,
                                                child: SvgPicture.asset(
                                                  AppImages.defaultCoachImage,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            )),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                SizedBox(
                                  height: 30.h,
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate(
                                        int.parse(((trainingDetails
                                                        ?.maxPlayers ??
                                                    0) -
                                                (trainingDetails?.joinsCount ??
                                                    0))
                                            .toString()),
                                        (index) => Container(
                                              width: 28.w,
                                              height: 28.h,
                                              margin: EdgeInsets.all(1.r),
                                              decoration: ShapeDecoration(
                                                color: AppColors
                                                    .greyWithOpacityColor
                                                    .withOpacity(1),
                                                shape: const OvalBorder(
                                                  eccentricity: 0,
                                                  side: BorderSide(
                                                      color: AppColors
                                                          .greyBorderColor),
                                                ),
                                              ),
                                              child: SvgPicture.asset(
                                                AppIcons.plus,
                                                height: 8.6.h,
                                                width: 8.6.w,
                                                fit: BoxFit.none,
                                              ),
                                            )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
            if (isCompleted) ...[
              SizedBox(
                height: 8.h,
              ),
              CustomTextWidget(
                text: AppStrings.sessionIsComplete,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.orangeRedColor,
              )
            ],
          ],
        );
      },
    );
  }
}
