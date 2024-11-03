import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../core/util/widgets/loading_widget/loading_widget.dart';
import '../../../model/enum_model/enum_details_models.dart';
import '../../../view_model/notification_cubit.dart';
import '../notification_card_widget.dart';

class NotificationPageViewWidget extends StatefulWidget {
  const NotificationPageViewWidget({super.key});

  @override
  State<NotificationPageViewWidget> createState() =>
      _NotificationPageViewWidgetState();
}

class _NotificationPageViewWidgetState
    extends State<NotificationPageViewWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    var cubit = NotificationCubit.get(context);
    scrollController.addListener(() {
      AppFunctions.logPrint(message: "Listennnnn");
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        AppFunctions.logPrint(message: "true");

        if ((cubit.newTotalPages) >= cubit.page) {
          AppFunctions.logPrint(message: "true");
          cubit.getNotifications();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        var cubit = NotificationCubit.get(context);

        if (state is MakeNotificationReadSuccessState) {
          cubit.getNotifications(myPage: 1);
        }
      },
      builder: (context, state) {
        var cubit = NotificationCubit.get(context);
        return Expanded(
          child: PageView(
            controller: cubit.pageController,
            onPageChanged: (index) {
              if (index == 0) {
                cubit.changeDetailsCategory(category: NotificationTabs.present);
              } else if (index == 1) {
                cubit.changeDetailsCategory(category: NotificationTabs.past);
              }
            },
            children: [
              AnimatedConditionalBuilder(
                condition: cubit.notificationsModel != null,
                builder: (context) => ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.r),
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    var list = cubit.notificationsModel?.data?.newNotifications;
                    if (index < (list?.length ?? 0)) {
                      return InkWell(
                        onTap: () {
                          cubit.makeNotificationRead(id: list?[index].id ?? '');
                        },
                        child: NotificationCardWidget(
                          data: list?[index],
                        ),
                      );
                    } else {
                      return cubit.newTotalPages >= cubit.page
                          ? LoadingWidget()
                          : SizedBox.shrink();
                    }
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemCount: cubit
                          .notificationsModel?.data?.newNotifications?.length ??
                      0,
                ),
                fallback: (context) => ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.r),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const NotificationCardWidget(
                      data: null,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 16.h);
                  },
                ),
              ),
              AnimatedConditionalBuilder(
                condition: cubit.notificationsModel != null,
                builder: (context) => ListView.separated(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 16.0.r),
                  itemBuilder: (context, index) {
                    var list =
                        cubit.notificationsModel?.data?.pastNotifications;
                    if (index < (list?.length ?? 0)) {
                      return NotificationCardWidget(
                        data: list?[index],
                      );
                    } else {
                      return cubit.pastTotalPages >= cubit.page
                          ? LoadingWidget()
                          : SizedBox.shrink();
                    }
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemCount: cubit.notificationsModel?.data?.pastNotifications
                          ?.length ??
                      0,
                ),
                fallback: (context) => ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.r),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const NotificationCardWidget(
                      data: null,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 16.h);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
