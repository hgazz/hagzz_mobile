import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/places_widget/places_widget.dart';
import 'package:bookit/features/home/view/widgets/departments_header_row_widget/department_header_row_loading_widget/department_header_row_loading_widget.dart';
import 'package:bookit/features/home/view_model/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/models/local_models/place_coach_model/place_coach_model.dart';
import '../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';
import '../departments_header_row_widget/departments_header_row_widget.dart';

class SuggestWidget extends StatelessWidget {
  const SuggestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              state is! HomeLoadingState
                  ? DepartmentsHeaderRowWidget(
                      firstText: AppStrings.academies,
                      lastText: AppStrings.browseAll,
                      onTap: () {
                        AppFunctions.namedNavigateTo(
                            context: context,
                            navigatedScreen: RouteConstants.allAcademies);
                      })
                  : const DepartmentHeaderRowLoadingWidget(),
              SizedBox(
                height: 15.h,
              ),
              state is! HomeLoadingState
                  ? AnimatedConditionalBuilder(
                      condition: HomeCubit.get(context)
                              .homeData
                              .data
                              ?.academies
                              ?.isNotEmpty ??
                          false,
                      builder: (context) => SizedBox(
                        height: 115.h,
                        child: BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            var cubit = HomeCubit.get(context);
                            var academies = cubit.homeData.data?.academies;
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var item = academies?[index];
                                return PlacesWidget(
                                  isVertical: false,
                                  data: PlaceCoachModel(
                                      id: item?.id ?? 0,
                                      // todo needs place holder image
                                      image: item?.logo ?? '',
                                      name: item?.commercialName ?? '',
                                      department:
                                          AppFunctions.getStringFromList(
                                              item: item?.sports ?? []),
                                      // todo : change the following to the actual data
                                      following: item?.followsCount.toString(),
                                      rate: null),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                width: 8.w,
                              ),
                              itemCount: academies?.length ?? 0,
                            );
                          },
                        ),
                      ),
                      fallback: (context) => CustomTextWidget(
                        text: AppStrings.thereIsNoAcademies,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                        maxLine: 2,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : SizedBox(
                      height: 120.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return const PlacesWidget(
                            isVertical: false,
                            data: null,
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: 8.w,
                        ),
                        itemCount: 5,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
