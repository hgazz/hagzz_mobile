import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/auth/model/api_models/sports_model.dart';
import 'package:bookit/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:bookit/features/home/view/widgets/departments_header_row_widget/departments_header_row_widget.dart';
import 'package:bookit/features/home/view/widgets/sports_widget/sport_item_widget.dart';
import 'package:bookit/features/home/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../auth/view_model/auth_cubit/auth_state.dart';
import '../../../../bottom_nav_bar/view_model/bottom_nav_bar_cubit.dart';
import '../departments_header_row_widget/department_header_row_loading_widget/department_header_row_loading_widget.dart';

class SportsWidget extends StatelessWidget {
  const SportsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state is! HomeLoadingState
                  ? BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        var cubit = AuthCubit.get(context);
                        return DepartmentsHeaderRowWidget(
                            firstText: AppStrings.sports,
                            lastText: AppStrings.manage,
                            onTap: () {
                              if (CachedVariables.token != null) {
                                cubit.isProfile = false;
                                AppFunctions.namedNavigateTo(
                                    context: context,
                                    navigatedScreen:
                                        RouteConstants.updateSports);
                              } else {
                                AppAlert.success(
                                    message: AppFunctions.translateText(
                                        text: AppStrings.youMustLogin,
                                        context: context),
                                    context: context);
                                AppFunctions.namedNavigateTo(
                                    context: context,
                                    navigatedScreen: RouteConstants.enterPhone);
                                BottomNavBarCubit.get(context).changeIndex(0);
                              }
                            });
                      },
                    )
                  : const DepartmentHeaderRowLoadingWidget(),
              SizedBox(
                height: 15.h,
              ),
              state is! HomeLoadingState
                  ? SizedBox(
                      height: 84.h,
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (cubit.homeData.data
                                  ?.sportsRelatedUserAuthenticated?.isEmpty ??
                              false) {
                            return Center(
                              child: CustomTextWidget(
                                text: AppStrings.noSportsAvailable,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            );
                          }
                          return cubit
                                      .homeData
                                      .data
                                      ?.sportsRelatedUserAuthenticated?[0]
                                      ?.name !=
                                  null
                              ? ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      SportItemWidget(
                                    sport: cubit.homeData.data
                                                ?.sportsRelatedUserAuthenticated?[
                                            index] ??
                                        SportData(),
                                    isEmpty: false,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 4.w,
                                  ),
                                  itemCount: cubit
                                          .homeData
                                          .data
                                          ?.sportsRelatedUserAuthenticated
                                          ?.length ??
                                      0,
                                )
                              : SportItemWidget(
                                  sport: SportData(),
                                  isEmpty: true,
                                );
                        },
                      ),
                    )
                  : SizedBox(
                      height: 90.h,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            const SportItemWidget(sport: null, isEmpty: false),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 8.w,
                        ),
                        itemCount: 8,
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
