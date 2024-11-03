import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/models/api_models/training_model/training_model.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/bottom_nav_bar/view_model/bottom_nav_bar_cubit.dart';
import 'package:bookit/features/home/view/widgets/departments_header_row_widget/department_header_row_loading_widget/department_header_row_loading_widget.dart';
import 'package:bookit/features/home/view_model/home_cubit.dart';
import 'package:bookit/features/search/view_model/search_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_alert/app_alert.dart';
import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/training_card_widget/training_card_widget.dart';
import '../departments_header_row_widget/departments_header_row_widget.dart';

class NearsMeWidget extends StatelessWidget {
  const NearsMeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              state is! HomeLoadingState
                  ? DepartmentsHeaderRowWidget(
                      firstText: AppStrings.nearMe,
                      lastText: AppStrings.seeAll,
                      trainingsCount: cubit.homeData.data?.trainingCount,
                      onTap: () {
                        if (CachedVariables.token != null) {
                          BottomNavBarCubit.get(context).changeIndex(1);
                          SearchCubit.get(context)
                              .changeSelectedQuickFilters(0);
                          SearchCubit.get(context).getSearchData();
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
                      })
                  : const DepartmentHeaderRowLoadingWidget(),
              SizedBox(
                height: 13.h,
              ),
              state is! HomeLoadingState
                  ? cubit.homeData.data?.training?.isNotEmpty ?? false
                      ? SizedBox(
                          height: 320.h,
                          child: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              var cubit = HomeCubit.get(context);
                              var trainingList = cubit.homeData.data?.training;
                              return ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => FittedBox(
                                  child: TrainingCardWidget(
                                    trainingItem:
                                        trainingList?[index] ?? TrainingModel(),
                                    isVertical: false,
                                    isPast: false,
                                    index: index,
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 8.w,
                                ),
                                itemCount: trainingList?.length ?? 0,
                              );
                            },
                          ),
                        )
                      : CustomTextWidget(
                          text: AppStrings.thereIsNoTrainings,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        )
                  : SizedBox(
                      height: 320.h,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => const FittedBox(
                          child: TrainingCardWidget(
                            trainingItem: null,
                            isVertical: false,
                            isPast: false,
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 8.w,
                        ),
                        itemCount: 5,
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
