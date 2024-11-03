import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/bottom_widget/bottom_widget.dart';
import 'package:bookit/core/util/widgets/text_bottom_widget/text_bottom_widget.dart';
import 'package:bookit/features/auth/view/choose_sports_screen/widgets/sports_item_widget/sports_item.dart';
import 'package:bookit/features/profile/view/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/widgets/loading_widget/loading_widget.dart';
import '../../model/api_models/sports_model.dart';
import '../../view_model/choose_sports_cubit/choose_sports_cubit.dart';

class ChooseSportsScreen extends StatefulWidget {
  const ChooseSportsScreen({super.key});

  @override
  State<ChooseSportsScreen> createState() => _ChooseSportsScreenState();
}

class _ChooseSportsScreenState extends State<ChooseSportsScreen> {
  @override
  void initState() {
    var cubit = ChooseSportsCubit.get(context);
    cubit.getSports();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChooseSportsCubit, ChooseSportsState>(
        listener: (context, state) {
          var cubit = ChooseSportsCubit.get(context);

          if (state is UpdateSportsSuccessState) {
            cubit.sportsLevel = [];
            cubit.chooseSports = [];
            cubit.userSports = [];
            AppFunctions.namedNavigateAndFinishTo(
                context: context, navigatedScreen: RouteConstants.bottomNavBar);
          }
        },
        builder: (context, state) {
          var cubit = ChooseSportsCubit.get(context);
          return SafeArea(
            child: Column(
              children: [
                HeaderWidget(
                    isShowBack: false,
                    backOnPressed: () {
                      AppFunctions.popNavigate(context: context);
                    },
                    title: AppStrings.selectInterests),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AnimatedConditionalBuilder(
                              condition: cubit.sportsModel != null,
                              builder: (context) => ListView.separated(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) => SportsItem(
                                      index: index,
                                      data: cubit.sportsModel?.data?[index] ??
                                          SportData(),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 8.h,
                                    ),
                                    itemCount:
                                        cubit.sportsModel?.data?.length ?? 0,
                                  ),
                              fallback: (context) => const LoadingWidget()),
                        ),
                        BottomWidget(
                          text: AppStrings.next,
                          onTap: () {
                            List<String> sports = [];
                            List<String> levels = [];

                            cubit.sportsModel?.data?.forEach((element) {
                              if (element.level != null) {
                                sports.add(element.id.toString());
                                levels.add(element.level ?? '');
                              }
                            });
                            cubit.updateSports(sports: sports, levels: levels);
                          },
                          isLoading:
                              state is UpdateSportsLoadingState ? true : false,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        TextBottomWidget(
                            text: AppStrings.skipForNow,
                            textColor: AppColors.textGreyColor,
                            fontSize: 16,
                            onTap: () {
                              AppFunctions.namedNavigateTo(
                                context: context,
                                navigatedScreen: RouteConstants.bottomNavBar,
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
