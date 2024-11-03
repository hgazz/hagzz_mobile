import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/features/bottom_nav_bar/view_model/bottom_nav_bar_cubit.dart';
import 'package:bookit/features/bottom_nav_bar/view_model/bottom_nav_bar_state.dart';
import 'package:bookit/features/profile/view_model/my_sessions_cubit/my_sessions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:upgrader/upgrader.dart';

import '../../profile/model/enum_model/enum_details_models.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Future<bool> checkConnection() async {
    return await InternetConnection().hasInternetAccess;
  }

  @override
  void initState() {
    // BottomNavBarCubit.get(context).changeIndex(0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavBarCubit, BottomNavBarState>(
      listener: (context, state) {
        var cubit = BottomNavBarCubit.get(context);
        if (state is CheckForUpdateSuccessState) {
          AppFunctions.logPrint(
              message: "Resulttt: ${cubit.updateInfo?.updateAvailability}");
        }

        if (state is ChangeBottomNavBarState) {
          if (cubit.currentIndex == 2) {
            MySessionsCubit.get(context).mySessionsCategories =
                MySessionsCategories.upcoming;
            MySessionsCubit.get(context).page = 1;
            MySessionsCubit.get(context).getMySessions();
          }
        }
      },
      builder: (context, state) {
        var cubit = BottomNavBarCubit.get(context);
        return Scaffold(
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Color(0xffF2F2F2),
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: cubit.authItems(context: context)),
        );
        return UpgradeAlert(
          showLater: false,
          showIgnore: false,
          barrierDismissible: true,
          showReleaseNotes: false,
          dialogStyle: UpgradeDialogStyle.cupertino,
          child: Scaffold(
            body: cubit.screen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: cubit.authItems(context: context)),
          ),
        );
      },
    );
  }
}
