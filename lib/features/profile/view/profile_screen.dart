import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:bookit/features/profile/view/widgets/delete_account/delete_account.dart';
import 'package:bookit/features/profile/view/widgets/logout_widget/logout_widget.dart';
import 'package:bookit/features/profile/view/widgets/user_data_widget/user_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/widgets/not_auth_widget/not_auth_widget.dart';
import 'widgets/profile_card_widget.dart';
import 'widgets/profile_menu_item_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CachedVariables.token == null &&
                  AuthCubit.get(context).token == null
              ? NotAuthWidget()
              : Column(
                  children: [
                    CachedVariables.token != null
                        ? const UserDataWidget()
                        : SizedBox.shrink(),
                    SizedBox(
                      height: 16.h,
                    ),
                    CachedVariables.token != null
                        ? Row(
                            children: [
                              const ProfileCardWidget(
                                title: AppStrings.saved,
                                icon: AppIcons.savedOutlined,
                                navigatedScreen: RouteConstants.saved,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              const ProfileCardWidget(
                                title: AppStrings.myBooking,
                                icon: AppIcons.calenderSVG,
                                navigatedScreen: RouteConstants.mySessions,
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      height: 16.h,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          // general section
                          // CustomTextWidget(
                          //   text: AppStrings.general,
                          //   fontSize: 14.sp,
                          //   fontWeight: FontWeight.w500,
                          //   color: AppColors.greyColor,
                          // ),
                          // SizedBox(
                          //   height: 8.h,
                          // ),
                          CachedVariables.token != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainer,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Column(
                                    children: [
                                      ProfileMenuItemWidget(
                                        title: AppStrings.following,
                                        icon: AppIcons.following,
                                        onTap: () {
                                          AppFunctions.namedNavigateTo(
                                              context: context,
                                              navigatedScreen:
                                                  RouteConstants.following);
                                        },
                                      ),
                                      ProfileMenuItemWidget(
                                        title: AppStrings.inviteYourFriends,
                                        icon: AppIcons.inviteFriend,
                                        onTap: () {
                                          AppFunctions.namedNavigateTo(
                                              context: context,
                                              navigatedScreen:
                                                  RouteConstants.inviteFriend);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),

                          SizedBox(
                            height: 12.h,
                          ),
                          // preferences section
                          // CustomTextWidget(
                          //   text: AppStrings.preferences,
                          //   fontSize: 14.sp,
                          //   fontWeight: FontWeight.w500,
                          //   color: AppColors.greyColor,
                          // ),
                          // SizedBox(
                          //   height: 8.h,
                          // ),

                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              children: [
                                ProfileMenuItemWidget(
                                  title: AppStrings.settings,
                                  icon: AppIcons.settings,
                                  onTap: () {
                                    AppFunctions.namedNavigateTo(
                                        context: context,
                                        navigatedScreen:
                                            RouteConstants.settings);
                                  },
                                ),
                                ProfileMenuItemWidget(
                                  title: AppStrings.support,
                                  icon: AppIcons.support,
                                  onTap: () {
                                    AppFunctions.namedNavigateTo(
                                        context: context,
                                        navigatedScreen:
                                            RouteConstants.support);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          // support section
                          CustomTextWidget(
                            text: AppStrings.more,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyColor,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              children: [
                                ProfileMenuItemWidget(
                                  title: AppStrings.terms,
                                  icon: AppIcons.terms,
                                  onTap: () {
                                    AppFunctions.namedNavigateTo(
                                        context: context,
                                        navigatedScreen:
                                            RouteConstants.termsAndConditions);
                                  },
                                ),
                                // ProfileMenuItemWidget(
                                //   title: AppStrings.rateBookit,
                                //   icon: AppIcons.rateOutlined,
                                //   onTap: () {},
                                // ),
                                // ProfileMenuItemWidget(
                                //   title: AppStrings.reportABug,
                                //   icon: AppIcons.bug,
                                //   onTap: () {},
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          // more section
                          CustomTextWidget(
                            text: AppStrings.account,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyColor,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          // sign out
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              children: [
                                const LogoutWidget(),
                                const DeleteAccountWidget(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
