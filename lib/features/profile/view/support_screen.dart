import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/features/profile/view/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/router/rout_constants.dart';
import '../../../core/util/constants/app_functions/app_functions.dart';
import 'widgets/profile_menu_item_widget.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

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
            title: AppStrings.support,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        title: AppStrings.help,
                        icon: AppIcons.help,
                        onTap: () {
                          AppFunctions.namedNavigateTo(
                              context: context,
                              navigatedScreen: RouteConstants.helpAndSupport);
                        },
                      ),
                      ProfileMenuItemWidget(
                        title: AppStrings.faqs,
                        icon: AppIcons.faqs,
                        onTap: () {
                          AppFunctions.namedNavigateTo(
                              context: context,
                              navigatedScreen: RouteConstants.faqs);
                        },
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
