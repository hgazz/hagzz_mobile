import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/loading_widget/loading_widget.dart';
import 'package:bookit/core/util/widgets/rounded_container_widget/rounded_container_widget.dart';
import 'package:bookit/features/home/view/widgets/nears_me_widget/near_me_widget.dart';
import 'package:bookit/features/home/view/widgets/slider_widget/slider_widget.dart';
import 'package:bookit/features/home/view/widgets/sports_widget/sports_widget.dart';
import 'package:bookit/features/home/view/widgets/suggest_widget/suggest_widget.dart';
import 'package:bookit/features/home/view_model/home_cubit.dart';
import 'package:bookit/features/notifications/view_model/notification_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:toastification/toastification.dart';

import '../../../core/helper/cach/cach_helper.dart';
import '../../../core/helper/cach/cached_keys.dart';
import '../../../core/util/constants/app_alert/app_alert.dart';
import '../../../core/util/widgets/app_bar_widget/app_bar_widget.dart';
import '../../edit_profile/view_model/edit_profile_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppUpdateInfo? _updateInfo;

  bool? hasDuration;

  @override
  void initState() {
    InternetConnection().onStatusChange.listen((InternetStatus status) {
      AppFunctions.logPrint(message: "Statussss: $status");
      switch (status) {
        case InternetStatus.connected:
          toastification.dismissAll();
          break;
        case InternetStatus.disconnected:
          AppAlert.error(
            message: AppFunctions.translateText(
                text: AppStrings.lostConnectionMessage, context: context),
            context: context,
            hasDuration: false,
          );
          break;
      }
    });
    if (CachedVariables.token != null) {
      EditProfileCubit.get(context).getUserData();
    }

    HomeCubit.get(context).getHomeData(context: context);
    checkForUpdate();
    super.initState();
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      AppFunctions.logPrint(message: "Info: ${info}");

      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      AppFunctions.logPrint(message: "Errorrr: ${e.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        hasLeading: false,
        titleWidget: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) async {
            var cubit = EditProfileCubit.get(context);

            if (state is GetUserProfileDataSuccessState) {
              if (cubit.userModel?.data?.profile?.language !=
                  CachedVariables.lang) {
                final localization = EasyLocalization.of(context);
                if (localization != null) {
                  context.setLocale(Locale(
                      cubit.userModel?.data?.profile?.language ?? 'en', ""));
                  await CacheHelper.setData(
                      key: CachedKeys.lang,
                      value: cubit.userModel?.data?.profile?.language ?? 'en');
                  CachedVariables.lang =
                      await CacheHelper.getData(key: CachedKeys.lang);
                }
              }
            }
          },
          builder: (context, state) {
            var cubit = EditProfileCubit.get(context);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "${AppFunctions.translateText(text: AppStrings.hello, context: context)}${CachedVariables.token != null ? ',' : "!"} ${(cubit.userModel?.data?.profile?.name?.split(" ")[0]) ?? ''}",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            );
          },
        ),
        actions: [
          // RoundedContainerWidget(
          //   image: AppIcons.trophy,
          //   onTap: () {},
          // ),

          CachedVariables.token != null
              ? BlocProvider(
                  create: (context) => NotificationCubit()..getNotifications(),
                  child: BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      var cubit = NotificationCubit.get(context);
                      return RoundedContainerWidget(
                        image: AppIcons.notification,
                        onTap: () {
                          if (CachedVariables.token != null) {
                            AppFunctions.namedNavigateTo(
                                context: context,
                                navigatedScreen: RouteConstants.notification);
                          } else {
                            AppAlert.success(
                                message: AppFunctions.translateText(
                                    text: AppStrings.youMustLogin,
                                    context: context),
                                context: context);
                            AppFunctions.namedNavigateTo(
                                context: context,
                                navigatedScreen: RouteConstants.enterPhone);
                          }
                        },
                        hasNotify: cubit.notificationsModel?.data
                                    ?.newNotifications?.isNotEmpty ??
                                false
                            ? true
                            : false,
                      );
                    },
                  ),
                )
              : RoundedContainerWidget(
                  image: AppIcons.notification,
                  onTap: () {
                    if (CachedVariables.token != null) {
                      AppFunctions.namedNavigateTo(
                          context: context,
                          navigatedScreen: RouteConstants.notification);
                    } else {
                      AppAlert.success(
                          message: AppFunctions.translateText(
                              text: AppStrings.youMustLogin, context: context),
                          context: context);
                      AppFunctions.namedNavigateTo(
                          context: context,
                          navigatedScreen: RouteConstants.enterPhone);
                    }
                  },
                  hasNotify: false,
                ),
          RoundedContainerWidget(
            image: AppIcons.help,
            onTap: () {
              AppFunctions.namedNavigateTo(
                  context: context,
                  navigatedScreen: RouteConstants.helpAndSupport);
            },
          ),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeErrorState) {
            if (state.error.contains("[connection error]")) {
              toastification.dismissAll();
              AppAlert.error(
                  message: AppFunctions.translateText(
                      text: AppStrings.lostConnectionMessage, context: context),
                  context: context,
                  hasDuration: false);
            }
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          if (state is HomeErrorState) {
            return LoadingWidget();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                  color: AppColors.greyBorderColor,
                ),
                SizedBox(
                  height: 16.h,
                ),
                const SliderWidget(),
                SizedBox(
                  height: 16.h,
                ),
                const SportsWidget(),
                SizedBox(
                  height: 16.h,
                ),
                const SuggestWidget(),
                SizedBox(
                  height: 16.h,
                ),
                const NearsMeWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
