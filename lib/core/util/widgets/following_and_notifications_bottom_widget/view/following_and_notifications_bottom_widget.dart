import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/core/util/widgets/following_and_notifications_bottom_widget/model/type_data.dart';
import 'package:bookit/core/util/widgets/following_and_notifications_bottom_widget/view_model/following_notifications_cubit.dart';
import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:bookit/features/following/view_model/following_cubit.dart';
import 'package:bookit/features/home/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helper/router/rout_constants.dart';
import '../../../constants/app_colors/app_colors.dart';
import '../../../constants/app_functions/app_functions.dart';
import '../../../constants/app_strings/app_strings.dart';
import '../../following_bottom_widget/following_bottom_widget.dart';

class FollowingAndNotificationsBottomWidget extends StatelessWidget {
  final TypeData? data;

  const FollowingAndNotificationsBottomWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return data != null
        ? BlocProvider(
            create: (context) => FollowingNotificationsCubit()
              ..setFollowing(isFollow: data!.isFollow),
            child: BlocConsumer<FollowingNotificationsCubit,
                FollowingNotificationsState>(
              listener: (context, state) {
                var cubit = FollowingNotificationsCubit.get(context);

                if (state is ChangeFollowingSuccessState) {
                  AppAlert.success(message: state.message, context: context);
                  cubit.changeFollowingState();
                  FollowingCubit.get(context).getFollowData(myPage: 1);
                  HomeCubit.get(context).getHomeData(context: context);
                }
                if (state is ChangeFollowingErrorState) {
                  AppAlert.error(message: state.error, context: context);
                }
              },
              builder: (context, state) {
                var cubit = FollowingNotificationsCubit.get(context);
                return Row(
                  children: [
                    FollowingBottomWidget(
                      isFollowing: cubit.isFollowing,
                      onTap: () {
                        if (CachedVariables.token != null) {
                          cubit.changeFollowing(data: data!);
                        } else {
                          AppAlert.success(
                            message: AppFunctions.translateText(
                                text: AppStrings.youMustLogin,
                                context: context),
                            context: context,
                          );
                          AppFunctions.namedNavigateTo(
                              context: context,
                              navigatedScreen: RouteConstants.enterPhone);
                        }
                      },
                      backgroundColor:
                          cubit.isFollowing ? null : AppColors.lemonColor,
                    ),
                    // SizedBox(
                    //   width: 8.w,
                    // ),
                    // const CircleNotificationIconWidget()
                  ],
                );
              },
            ),
          )
        : ShimmerWidget(width: double.infinity, height: 40.h);
  }
}
