import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/not_auth_widget/not_auth_widget.dart';
import 'package:bookit/core/util/widgets/training_card_loading_widget/training_card_loading_widget.dart';
import 'package:bookit/core/util/widgets/training_card_widget/training_card_widget.dart';
import 'package:bookit/features/profile/model/enum_model/enum_details_models.dart';
import 'package:bookit/features/profile/view/widgets/header_widget.dart';
import 'package:bookit/features/profile/view/widgets/my_booking_empty_widget/my_booking_empty_widget.dart';
import 'package:bookit/features/profile/view/widgets/selected_my_sessions_widget.dart';
import 'package:bookit/features/profile/view_model/my_sessions_cubit/my_sessions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/constants/app_alert/app_alert.dart';

class MySessionsScreen extends StatefulWidget {
  final bool isBack;

  const MySessionsScreen({super.key, required this.isBack});

  @override
  State<MySessionsScreen> createState() => _MySessionsScreenState();
}

class _MySessionsScreenState extends State<MySessionsScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    MySessionsCubit.get(context).page = 1;
    MySessionsCubit.get(context).mySessionsCategories =
        MySessionsCategories.upcoming;

    var cubit = MySessionsCubit.get(context);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (cubit.totalPages >= cubit.page) {
          cubit.getMySessions();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MySessionsCubit, MySessionsState>(
        listener: (context, state) {
          if (state is GetSavedDateErrorState) {
            if (state.error.contains("[connection error]")) {
              AppAlert.error(
                  message: AppFunctions.translateText(
                      text: AppStrings.lostConnectionMessage, context: context),
                  context: context);
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                if (!widget.isBack)
                  SizedBox(
                    height: 5.h,
                  ),
                HeaderWidget(
                  isShowBack: widget.isBack,
                  backOnPressed: () {
                    MySessionsCubit.get(context).clearData();
                    AppFunctions.popNavigate(context: context);
                  },
                  title: AppFunctions.translateText(
                      text: AppStrings.myBooking, context: context),
                ),
                if (CachedVariables.token != null) ...[
                  const SelectedMySessionsWidget(),
                  Expanded(
                    child: BlocBuilder<MySessionsCubit, MySessionsState>(
                      builder: (context, state) {
                        var cubit = MySessionsCubit.get(context);
                        var upcoming = cubit.upcomingMySessions;
                        var past = cubit.pastMySessions;
                        var isLoading = state is GetMySessionsLoadingState;
                        return PageView(
                          onPageChanged: (index) {
                            if (index == 0) {
                              cubit.changeDetailsCategory(
                                  category: MySessionsCategories.upcoming);
                            } else {
                              cubit.changeDetailsCategory(
                                  category: MySessionsCategories.past);
                            }
                          },
                          controller: cubit.pageController,
                          children: [
                            AnimatedConditionalBuilder(
                              condition: cubit.isUpcomingEmpty != null,
                              builder: (context) => AnimatedConditionalBuilder(
                                  condition: cubit.isUpcomingEmpty == false,
                                  builder: (context) => ListView.separated(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w, vertical: 16.h),
                                        itemCount: isLoading
                                            ? upcoming.length + 1
                                            : upcoming.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (isLoading &&
                                              upcoming.length == 0) {
                                            return TrainingCardLoadingWidget();
                                          }
                                          if (index < upcoming.length) {
                                            var current = upcoming[index];
                                            return TrainingCardWidget(
                                              isVertical: true,
                                              isPast: false,
                                              trainingItem: current,
                                            );
                                          } else {
                                            return TrainingCardLoadingWidget();
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(height: 8);
                                        },
                                      ),
                                  fallback: (context) => MyBookingEmptyWidget(
                                        isPast: false,
                                        isBack: widget.isBack,
                                      )),
                              fallback: (context) => ListView.separated(
                                padding: EdgeInsets.all(16.r),
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        TrainingCardWidget(
                                            isVertical: true,
                                            isPast: false,
                                            trainingItem: null),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                  height: 5.h,
                                ),
                                itemCount: 3,
                              ),
                            ),
                            AnimatedConditionalBuilder(
                              condition: cubit.isPastEmpty != null,
                              builder: (context) => AnimatedConditionalBuilder(
                                  condition: cubit.isPastEmpty == false,
                                  builder: (context) => ListView.separated(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w, vertical: 16.h),
                                        itemCount: isLoading
                                            ? past.length + 1
                                            : past.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (isLoading && past.length == 0) {
                                            return TrainingCardLoadingWidget();
                                          }
                                          if (index < past.length) {
                                            var current = past[index];
                                            return TrainingCardWidget(
                                              isVertical: true,
                                              isPast: false,
                                              trainingItem: current,
                                            );
                                          } else {
                                            return TrainingCardLoadingWidget();
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(height: 8);
                                        },
                                      ),
                                  fallback: (context) => MyBookingEmptyWidget(
                                        isPast: true,
                                        isBack: widget.isBack,
                                      )),
                              fallback: (context) => ListView.separated(
                                padding: EdgeInsets.all(16.r),
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        TrainingCardWidget(
                                            isVertical: true,
                                            isPast: false,
                                            trainingItem: null),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                  height: 5.h,
                                ),
                                itemCount: 3,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
                if (CachedVariables.token == null)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: NotAuthWidget(),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
