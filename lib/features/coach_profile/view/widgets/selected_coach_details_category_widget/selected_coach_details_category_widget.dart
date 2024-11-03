import 'package:bookit/features/coach_profile/model/enum_datails_catgory/enum_details_category.dart';
import 'package:bookit/features/coach_profile/view_model/coach_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/tab_item_widget/tab_item_widget.dart';

class SelectedCoachDetailsCategoryWidget extends StatelessWidget {
  const SelectedCoachDetailsCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoachProfileCubit, CoachProfileState>(
      builder: (context, state) {
        var cubit = CoachProfileCubit.get(context);
        return Container(
          width: 283.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              color: AppColors.surfaceContainer),
          child: Row(
            children: [
              Expanded(
                child: TabItemWidget(
                  onTap: () {
                    cubit.changeCoachDetailsCategory(
                        category: CoachDetailsCategory.upcoming);
                  },
                  text: AppStrings.upcoming,
                  isEnable: cubit.coachDetailsCategory ==
                          CoachDetailsCategory.upcoming
                      ? true
                      : false,
                ),
              ),
              Expanded(
                child: TabItemWidget(
                  onTap: () {
                    cubit.changeCoachDetailsCategory(
                        category: CoachDetailsCategory.past);
                  },
                  text: AppStrings.past,
                  isEnable:
                      cubit.coachDetailsCategory == CoachDetailsCategory.past
                          ? true
                          : false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
