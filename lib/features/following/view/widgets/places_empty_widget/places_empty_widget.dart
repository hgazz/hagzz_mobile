import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
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
import '../../../../home/view/widgets/departments_header_row_widget/departments_header_row_widget.dart';
import '../../../../home/view_model/home_cubit.dart';

class PlacesEmptyWidget extends StatelessWidget {
  const PlacesEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmptyWidget(
          data: EmptyModel(
              isFollowing: true,
              image: AppImages.emptyFollow,
              title: AppStrings.emptyFollowPlacesMessage,
              description: AppStrings.emptyFollowPlacesLabelMessage),
        ),
        SizedBox(
          height: 24.h,
        ),
        DepartmentsHeaderRowWidget(
            firstText: AppStrings.suggest,
            lastText: AppStrings.browseAll,
            onTap: () {
              AppFunctions.namedNavigateTo(
                  context: context,
                  navigatedScreen: RouteConstants.allAcademies);
            }),
        SizedBox(
          height: 8.h,
        ),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return cubit.homeData.data?.academies?.isNotEmpty ?? false
                ? Expanded(
                    child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var item = cubit.homeData.data?.academies?[index];
                      return PlacesWidget(
                        isVertical: true,
                        data: PlaceCoachModel(
                            id: item?.id ?? 0,
                            // todo needs place holder image
                            image: item?.logo ?? '',
                            name: item?.commercialName ?? '',
                            department: AppFunctions.getStringFromList(
                                item: item?.sports ?? []),
                            // todo : change the following to the actual data
                            following: item?.followsCount.toString(),
                            rate: null),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8.w,
                    ),
                    itemCount: cubit.homeData.data?.academies?.length ?? 0,
                  ))
                : CustomTextWidget(
                    text: AppStrings.thereIsNoAcademies,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  );
          },
        )
      ],
    );
  }
}
