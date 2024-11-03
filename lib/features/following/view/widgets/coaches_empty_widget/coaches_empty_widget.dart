import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/features/following/view_model/following_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/router/rout_constants.dart';
import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../core/util/constants/app_images/app_images.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/models/local_models/empty_model_data/empty_model.dart';
import '../../../../../core/util/models/local_models/place_coach_model/place_coach_model.dart';
import '../../../../../core/util/widgets/empty_widget/empty_widget.dart';
import '../../../../../core/util/widgets/places_widget/places_widget.dart';
import '../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';
import '../../../../home/view/widgets/departments_header_row_widget/departments_header_row_widget.dart';

class CoachesEmptyWidget extends StatelessWidget {
  const CoachesEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmptyWidget(
          data: EmptyModel(
              isFollowing: true,
              image: AppImages.emptyFollow,
              title: AppStrings.emptyFollowCoachesMessage,
              description: AppStrings.emptyFollowCoachesLabelMessage),
        ),
        SizedBox(
          height: 24.h,
        ),
        DepartmentsHeaderRowWidget(
            firstText: AppStrings.forU,
            lastText: AppStrings.seeAll,
            onTap: () {
              AppFunctions.namedNavigateTo(
                  context: context, navigatedScreen: RouteConstants.allCoaches);
            }),
        SizedBox(
          height: 8.h,
        ),
        BlocConsumer<FollowingCubit, FollowingState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = FollowingCubit.get(context);
            return AnimatedConditionalBuilder(
                condition: cubit.coachesForUModel != null,
                builder: (context) => AnimatedConditionalBuilder(
                    condition:
                        cubit.coachesForUModel?.data?.isNotEmpty ?? false,
                    builder: (context) => SizedBox(
                          height: 110.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var item = cubit.coachesForUModel?.data?[index];
                              return PlacesWidget(
                                isVertical: true,
                                data: PlaceCoachModel(
                                    id: item?.id ?? 0,
                                    image: item?.image ?? '',
                                    name: item?.name ?? '',
                                    department: AppFunctions.getStringFromList(
                                        item: item?.sports ?? []),
                                    // todo : change the following to the actual data
                                    following: null,
                                    rate: "2"),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: 8.w,
                            ),
                            itemCount:
                                cubit.coachesForUModel?.data?.length ?? 0,
                          ),
                        ),
                    fallback: (context) => CustomTextWidget(
                          text: AppStrings.thereIsNoCoaches,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        )),
                fallback: (context) => SizedBox());
          },
        )
      ],
    );
  }
}
