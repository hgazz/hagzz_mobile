import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/features/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:bookit/features/following/view_model/following_cubit.dart';
import 'package:bookit/features/home/view_model/home_cubit.dart';
import 'package:bookit/features/profile/view_model/my_sessions_cubit/my_sessions_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../features/auth/view_model/auth_cubit/auth_cubit.dart';
import '../../features/auth/view_model/choose_sports_cubit/choose_sports_cubit.dart';
import '../../features/bottom_nav_bar/view_model/bottom_nav_bar_cubit.dart';
import '../../features/notifications/view_model/notification_cubit.dart';
import '../../features/profile/view_model/profile_cubit/profile_cubit.dart';
import '../../features/saved/view_model/saved_cubit.dart';
import '../../features/search/view_model/search_cubit.dart';
import '../../features/session/view_model/session_cubit.dart';
import '../../main.dart';
import '../helper/cach/cached_variables.dart';
import '../helper/router/app_router.dart';
import '../helper/router/rout_constants.dart';
import '../util/constants/app_alert/app_alert.dart';
import '../util/constants/app_colors/app_colors.dart';
import '../util/constants/app_strings/app_strings.dart';
import '../util/widgets/address_widget/view_model/address_cubit.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  void initState() {
    InternetConnection().onStatusChange.listen((InternetStatus status) {
      AppFunctions.logPrint(message: "Statussss: $status");
      switch (status) {
        case InternetStatus.connected:
          break;
        case InternetStatus.disconnected:
          AppAlert.error(
              message: AppFunctions.translateText(
                  text: AppStrings.lostConnectionMessage, context: context),
              context: context);
          break;
      }
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
          // BlocProvider(create: (context) => EnterPhoneCubit()),
          // BlocProvider(create: (context) => RegisterCubit()),
          BlocProvider(create: (context) => ChooseSportsCubit()),
          BlocProvider(create: (context) => EditProfileCubit()),
          // BlocProvider(create: (context) => OtpCubit()),
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => BottomNavBarCubit()),
          BlocProvider(create: (context) => SearchCubit()),
          BlocProvider(create: (context) => SessionCubit()),
          BlocProvider(create: (context) => SavedCubit()),
          BlocProvider(create: (context) => FollowingCubit()),
          BlocProvider(create: (context) => ProfileCubit()),
          BlocProvider(create: (context) => MySessionsCubit()),
          // BlocProvider(create: (context) => AcademyProfileCubit()),
          // BlocProvider(create: (context) => CoachProfileCubit()),
          BlocProvider(create: (context) => SavedCubit()),
          // BlocProvider(create: (context) => SessionCubit()),
          BlocProvider(create: (context) => NotificationCubit()),
          BlocProvider(create: (context) => AddressCubit()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, widget) => MaterialApp(
            title: "Hagzz",
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: RouteConstants.init,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            localeListResolutionCallback: (allLocales, supportedLocales) {
              final locale = allLocales?.first.languageCode;
              AppFunctions.logPrint(message: "Lan");
              if (locale == 'en') {
                CachedVariables.lang = locale;
                return const Locale('en');
              } else {
                CachedVariables.lang = locale;
                return const Locale('ar');
              }
            },
            theme: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              scaffoldBackgroundColor: Color(0xffF2F2F2),
              tabBarTheme: TabBarThemeData(
                  labelStyle: GoogleFonts.inter(
                color: AppColors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              )),
              appBarTheme:
                  const AppBarTheme(backgroundColor: AppColors.transparent),
              navigationBarTheme: NavigationBarThemeData(
                  backgroundColor: AppColors.white, elevation: 0),
              colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: AppColors.primary,
                onPrimary: AppColors.onPrimary,
                secondary: AppColors.secondary,
                onSecondary: AppColors.onSecondary,
                error: AppColors.error,
                onError: AppColors.onError,
                surface: AppColors.surfaceContainer,
                background: AppColors.surface,
                onBackground: AppColors.onSurface,
                onSurface: AppColors.onSurface,
              ),
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: AppColors.surface,
              ),
              dropdownMenuTheme: DropdownMenuThemeData(
                  menuStyle: MenuStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          AppColors.surfaceContainer))),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: AppColors.black,
                unselectedItemColor: AppColors.black,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedLabelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: AppColors.black),
                unselectedLabelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.normal,
                    fontSize: 10.sp,
                    color: AppColors.black),
              ),
              useMaterial3: true,
            ),
          ),
        ));
  }
}
