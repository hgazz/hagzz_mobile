import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/features/profile/view/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/language_widget/language_widget.dart';
import 'widgets/profile_menu_item_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          HeaderWidget(
            backOnPressed: () {
              Navigator.pop(context);
            },
            title: AppStrings.settings,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      ProfileMenuItemWidget(
                        title: AppStrings.personalInformation,
                        icon: AppIcons.profileOutlined,
                        onTap: () {
                          // AuthCubit.get(context).isProfile = true;
                          AppFunctions.namedNavigateTo(
                              context: context,
                              navigatedScreen: RouteConstants.editProfile);
                        },
                      ),
                      ProfileMenuItemWidget(
                        title: AppStrings.activities,
                        icon: AppIcons.activities,
                        onTap: () {
                          // AuthCubit.get(context).isProfile = false;
                          AppFunctions.namedNavigateTo(
                              context: context,
                              navigatedScreen: RouteConstants.updateSports);
                        },
                      ),
                      ProfileMenuItemWidget(
                        title: AppStrings.language,
                        icon: AppIcons.language,
                        onTap: null,
                        trailing: LanguageWidget(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
