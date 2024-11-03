import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/tab_item_widget/tab_item_widget.dart';
import 'package:bookit/features/session/model/enum_model/enum_details_models.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedSessionDetailsDataWidget extends StatelessWidget {
  const SelectedSessionDetailsDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        var cubit = SessionCubit.get(context);
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: AppColors.greyWithOpacityColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: TabItemWidget(
                  onTap: () {
                    cubit.changeDetailsCategory(
                        category: SessionDetailsCategories.details);
                  },
                  text: AppStrings.details,
                  isEnable: cubit.sessionDetailsCategories ==
                          SessionDetailsCategories.details
                      ? true
                      : false,
                ),
              ),
              Expanded(
                child: TabItemWidget(
                  onTap: () {
                    cubit.changeDetailsCategory(
                        category: SessionDetailsCategories.classes);
                  },
                  text: AppStrings.classes,
                  isEnable: cubit.sessionDetailsCategories ==
                          SessionDetailsCategories.classes
                      ? true
                      : false,
                ),
              ),
              Expanded(
                child: TabItemWidget(
                  onTap: () {
                    cubit.changeDetailsCategory(
                        category: SessionDetailsCategories.chat);
                  },
                  text: AppStrings.chat,
                  isEnable: cubit.sessionDetailsCategories ==
                          SessionDetailsCategories.chat
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
