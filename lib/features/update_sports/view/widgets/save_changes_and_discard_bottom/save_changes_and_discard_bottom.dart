import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/features/auth/view_model/choose_sports_cubit/choose_sports_cubit.dart';
import 'package:bookit/features/bottom_nav_bar/view_model/bottom_nav_bar_cubit.dart';
import 'package:bookit/features/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/border_bottom_widget/border_bottom_widget.dart';
import '../../../../../core/util/widgets/bottom_widget/bottom_widget.dart';

class SaveChangesAndDiscardBottom extends StatelessWidget {
  const SaveChangesAndDiscardBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChooseSportsCubit, ChooseSportsState>(
      listener: (context, state) {
        var cubit = ChooseSportsCubit.get(context);

        if (state is UpdateSportsSuccessState) {
          BottomNavBarCubit.get(context).changeIndex(0);
          cubit.chooseSports = [];
          cubit.sportsLevel = [];
          cubit.userSports = [];
          EditProfileCubit.get(context).getUserData();
          EditProfileCubit.get(context).userSportIndex = -1;
          cubit.getUserSports();
          AppFunctions.namedNavigateAndFinishTo(
              context: context, navigatedScreen: RouteConstants.bottomNavBar);
        }
        if (state is UpdateSportsErrorState) {
          if (state.error.contains("[connection error]")) {
            AppAlert.error(
                message: AppFunctions.translateText(
                    text: AppStrings.lostConnectionMessage, context: context),
                context: context,
                hasDuration: false);
          } else {
            AppAlert.error(message: state.error, context: context);
          }
        }
        if (state is UpdateSportsValidationErrorState) {
          AppAlert.error(
              message: AppFunctions.translateText(
                  text: AppStrings.youMustChooseSport, context: context),
              context: context);
        }
      },
      builder: (context, state) {
        var cubit = ChooseSportsCubit.get(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              // cubit.profileHasChanges == true ? null : true
              BottomWidget(
                  isDisabled: null,
                  isLoading: state is! UpdateSportsLoadingState ? false : true,
                  height: 43,
                  text: AppStrings.saveChanges,
                  onTap: () {
                    List<String> sports = [];
                    List<String> levels = [];
                    EditProfileCubit.get(context).userSports.forEach((element) {
                      AppFunctions.logPrint(
                          message: "user sport ${element.sportId}");
                      if (element.levelName != "") {
                        sports.add(element.sportId.toString());
                        levels.add(element.levelName.toString());
                      }
                    });
                    cubit.chooseSports.forEach((element) {
                      AppFunctions.logPrint(
                          message: "choosen sport ${element.sportId}");

                      if (!sports.contains(element.sportId)) {
                        levels.add(element.levelName);
                        sports.add(element.sportId.toString());
                      }
                    });

                    cubit.updateSports(sports: sports, levels: levels);
                  }),
              SizedBox(
                height: 8.h,
              ),
              BorderBottomWidget(
                  text: AppStrings.discard,
                  onTap: () {
                    Navigator.pop(context);
                    EditProfileCubit.get(context).getUserData();
                    EditProfileCubit.get(context).userSportIndex = -1;
                    cubit.getSports();
                    cubit.chooseSports = [];
                    cubit.sportsLevel = [];
                    cubit.userSports = [];
                  }),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
