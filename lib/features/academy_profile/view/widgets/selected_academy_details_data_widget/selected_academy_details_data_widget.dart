import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:bookit/features/academy_profile/view_model/academy_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/tab_item_widget/tab_item_widget.dart';
import '../../../model/enum_model/enum_details_model.dart';

class SelectedAcademyDetailsDataWidget extends StatelessWidget {
  const SelectedAcademyDetailsDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AcademyProfileCubit, AcademyProfileState>(
      builder: (context, state) {
        var cubit = AcademyProfileCubit.get(context);
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              color: AppColors.surfaceContainer),
          child: Row(
            children: [
              Expanded(
                child: state is! GetAcademyDetailsLoadingState
                    ? TabItemWidget(
                        onTap: () {
                          cubit.pageViewController.animateToPage(0,
                              duration: Duration(microseconds: 1),
                              curve: Curves.bounceInOut);
                          cubit.changeDetailsCategory(
                              category: AcademyDetailsCategories.activities);
                        },
                        text: AppStrings.activities,
                        isEnable: cubit.academyDetailsCategories ==
                                AcademyDetailsCategories.activities
                            ? true
                            : false,
                      )
                    : ShimmerWidget(width: 60.w, height: 40.h),
              ),
              Expanded(
                child: state is! GetAcademyDetailsLoadingState
                    ? TabItemWidget(
                        onTap: () {
                          cubit.pageViewController.animateToPage(1,
                              duration: Duration(microseconds: 1),
                              curve: Curves.bounceInOut);
                          cubit.changeDetailsCategory(
                              category: AcademyDetailsCategories.gallery);
                        },
                        text: AppStrings.gallery,
                        isEnable: cubit.academyDetailsCategories ==
                                AcademyDetailsCategories.gallery
                            ? true
                            : false,
                      )
                    : ShimmerWidget(width: 60.w, height: 40.h),
              ),
              Expanded(
                child: state is! GetAcademyDetailsLoadingState
                    ? TabItemWidget(
                        onTap: () {
                          cubit.pageViewController.animateToPage(2,
                              duration: Duration(microseconds: 1),
                              curve: Curves.bounceInOut);
                          cubit.changeDetailsCategory(
                              category: AcademyDetailsCategories.about);
                        },
                        text: AppStrings.about,
                        isEnable: cubit.academyDetailsCategories ==
                                AcademyDetailsCategories.about
                            ? true
                            : false,
                      )
                    : ShimmerWidget(width: 60.w, height: 40.h),
              ),
            ],
          ),
        );
      },
    );
  }
}
