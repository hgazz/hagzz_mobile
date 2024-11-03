import 'package:bookit/features/following/view_model/following_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/tab_item_widget/tab_item_widget.dart';
import '../../../model/category_enum.dart';

class SelectedCategoryWidget extends StatelessWidget {
  const SelectedCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FollowingCubit, FollowingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = FollowingCubit.get(context);
        return Center(
          child: Container(
            width: 229.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                color: AppColors.greyWithOpacityColor),
            child: Row(
              children: [
                Expanded(
                  child: TabItemWidget(
                    onTap: () {
                      cubit.changeSelectedCategory(
                          category: FollowingCategory.places);
                    },
                    text: AppStrings.places,
                    isEnable: cubit.selectedCategory == FollowingCategory.places
                        ? true
                        : false,
                  ),
                ),
                Expanded(
                  child: TabItemWidget(
                    onTap: () {
                      cubit.changeSelectedCategory(
                          category: FollowingCategory.coaches);
                    },
                    text: AppStrings.coaches,
                    isEnable: cubit.selectedCategory != FollowingCategory.places
                        ? true
                        : false,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
