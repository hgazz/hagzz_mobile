import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/features/following/view_model/following_cubit.dart';
import 'package:bookit/features/profile/view/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/util/constants/app_lottie/app_lottie.dart';
import '../../../core/util/models/local_models/place_coach_model/place_coach_model.dart';
import '../../../core/util/widgets/places_widget/places_widget.dart';

class AllCoachesScreen extends StatelessWidget {
  const AllCoachesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FollowingCubit, FollowingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = FollowingCubit.get(context);
          return SafeArea(
            child: Column(
              children: [
                HeaderWidget(
                    backOnPressed: () {
                      AppFunctions.popNavigate(context: context);
                    },
                    title: AppStrings.allCoaches),
                cubit.coachesForUModel?.data?.isNotEmpty ?? false
                    ? Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.h),
                            itemBuilder: (context, index) {
                              var item = cubit.coachesForUModel?.data?[index];
                              return PlacesWidget(
                                isVertical: true,
                                data: PlaceCoachModel(
                                    id: item?.id ?? 0,
                                    image: item?.image ?? '',
                                    name: item?.name ?? '',
                                    department: AppFunctions.getStringFromList(
                                        item: item?.sports ?? []),
                                    // todo : change the following to the actual data
                                    following: null,
                                    rate: "2"),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                            itemCount:
                                cubit.coachesForUModel?.data?.length ?? 0))
                    : Center(child: Lottie.asset(AppLottie.noData))
              ],
            ),
          );
        },
      ),
    );
  }
}
