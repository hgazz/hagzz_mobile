import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/features/home/view/home_screen.dart';
import 'package:bookit/features/profile/view/my_sessions_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_update/in_app_update.dart';

import '../../../core/util/constants/app_colors/app_colors.dart';
import '../../../core/util/constants/app_functions/app_functions.dart';
import '../../../core/util/constants/app_icons/app_icons.dart';
import '../../../core/util/constants/app_strings/app_strings.dart';
import '../../profile/view/profile_screen.dart';
import '../../search/view/search_screen.dart';
import 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());

  static BottomNavBarCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  List<Widget> screen = [
    const HomeScreen(),
    const SearchScreen(),
    const MySessionsScreen(isBack: false),
    const ProfileScreen(),
  ];

  List<Widget> notAuthScreen = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  List<BottomNavigationBarItem> authItems({required context}) => [
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              AppIcons.homeSelectNavBarSVG,
              fit: BoxFit.scaleDown,
            ),
            icon: SvgPicture.asset(
              AppIcons.homeNavBarSVG,
              fit: BoxFit.cover,
            ),
            label: AppFunctions.translateText(
                text: AppStrings.home, context: context),
            backgroundColor:
                currentIndex == 0 ? AppColors.greyColor : AppColors.black),
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(AppIcons.exploreSelectNavBarSVG),
            icon: SvgPicture.asset(AppIcons.exploreNavBarSVG),
            label: AppFunctions.translateText(
                text: AppStrings.explore, context: context),
            backgroundColor: currentIndex == 1
                ? AppColors.greyWithOpacityColor
                : AppColors.black),
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              AppIcons.myBookingSelectNavBarSVG,
            ),
            icon: SvgPicture.asset(AppIcons.calenderSVG),
            label: AppFunctions.translateText(
                text: AppStrings.myBooking, context: context),
            backgroundColor: currentIndex == 2
                ? AppColors.greyWithOpacityColor
                : AppColors.black),
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(AppIcons.profileSelectNavBarSVG),
            icon: SvgPicture.asset(AppIcons.profileNavBarSVG),
            label: AppFunctions.translateText(
                text: AppStrings.profile, context: context),
            backgroundColor: currentIndex == 3
                ? AppColors.greyWithOpacityColor
                : AppColors.black),
      ];

  List<BottomNavigationBarItem> notAuthItems({required context}) => [
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              AppIcons.homeSelectNavBarSVG,
              fit: BoxFit.scaleDown,
            ),
            icon: SvgPicture.asset(
              AppIcons.homeNavBarSVG,
              fit: BoxFit.cover,
            ),
            label: AppFunctions.translateText(
                text: AppStrings.home, context: context),
            backgroundColor:
                currentIndex == 0 ? AppColors.greyColor : AppColors.black),
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(AppIcons.exploreSelectNavBarSVG),
            icon: SvgPicture.asset(AppIcons.exploreNavBarSVG),
            label: AppFunctions.translateText(
                text: AppStrings.explore, context: context),
            backgroundColor: currentIndex == 1
                ? AppColors.greyWithOpacityColor
                : AppColors.black),
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(AppIcons.profileSelectNavBarSVG),
            icon: SvgPicture.asset(AppIcons.profileNavBarSVG),
            label: AppFunctions.translateText(
                text: AppStrings.profile, context: context),
            backgroundColor: currentIndex == 3
                ? AppColors.greyWithOpacityColor
                : AppColors.black),
      ];
  AppUpdateInfo? updateInfo;

  Future<void> checkForUpdate({required context}) async {
    emit(CheckForUpdateLoadingState());
    await InAppUpdate.checkForUpdate().then((info) {
      updateInfo = info;
      emit(CheckForUpdateSuccessState());
    }).catchError((e) {
      AppFunctions.logPrint(message: "Erorrrr: ${e.toString()}");
      AppAlert.error(message: e.toString(), context: context);
      emit(CheckForUpdateErrorState(error: e.toString()));
    });
  }
}
