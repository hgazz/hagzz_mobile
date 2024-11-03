import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_images/app_images.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/models/local_models/empty_model_data/empty_model.dart';
import 'package:bookit/core/util/widgets/bottom_widget/bottom_widget.dart';
import 'package:bookit/core/util/widgets/empty_widget/empty_widget.dart';
import 'package:bookit/features/bottom_nav_bar/view_model/bottom_nav_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBookingEmptyWidget extends StatelessWidget {
  final bool isPast;
  final bool isBack;

  const MyBookingEmptyWidget(
      {super.key, required this.isPast, required this.isBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          EmptyWidget(
              data: EmptyModel(
                  image: AppImages.emptyMyBooking,
                  title: isPast
                      ? AppStrings.emptyPastMyBookingMessage
                      : AppStrings.emptyUpComingMyBookingMessage,
                  description: isPast
                      ? AppStrings.emptyPastMyBookingLabelMessage
                      : AppStrings.emptyUpComingMyBookingLabelMessage)),
          BottomWidget(
              text: AppStrings.explore,
              onTap: () {
                if (isBack) {
                  AppFunctions.popNavigate(context: context);
                }
                BottomNavBarCubit.get(context).changeIndex(1);
              },
              isLoading: false)
        ],
      ),
    );
  }
}
