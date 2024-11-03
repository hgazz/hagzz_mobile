import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/tab_item_widget/tab_item_widget.dart';
import 'package:bookit/features/profile/model/enum_model/enum_details_models.dart';
import 'package:bookit/features/profile/view_model/my_sessions_cubit/my_sessions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedMySessionsWidget extends StatelessWidget {
  const SelectedMySessionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MySessionsCubit, MySessionsState>(
      builder: (context, state) {
        var cubit = MySessionsCubit.get(context);
        return Container(
          width: 229.w,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: AppColors.surfaceContainer,
          ),
          child: Row(
            children: [
              Expanded(
                child: TabItemWidget(
                  onTap: () {
                    cubit.changeDetailsCategory(
                        category: MySessionsCategories.upcoming);
                  },
                  text: AppStrings.upcoming,
                  isEnable: cubit.mySessionsCategories ==
                          MySessionsCategories.upcoming
                      ? true
                      : false,
                ),
              ),
              Expanded(
                child: TabItemWidget(
                  onTap: () {
                    cubit.changeDetailsCategory(
                        category: MySessionsCategories.past);
                  },
                  text: AppStrings.past,
                  isEnable:
                      cubit.mySessionsCategories == MySessionsCategories.past
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
