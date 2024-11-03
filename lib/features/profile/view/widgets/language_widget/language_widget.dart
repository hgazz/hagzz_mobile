import 'package:bookit/core/helper/cach/cach_helper.dart';
import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/features/profile/view_model/profile_cubit/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/helper/cach/cached_keys.dart';
import '../../../../../core/util/constants/app_colors/app_colors.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  @override
  void initState() {
    ProfileCubit.get(context).setLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) async {
        var cubit = ProfileCubit.get(context);

        if (state is SendLanguageSuccessState) {
          if (!state.isEnglish) {
            final localization = EasyLocalization.of(context);
            if (localization != null) {
              context.setLocale(const Locale("ar", ""));
              await CacheHelper.setData(key: CachedKeys.lang, value: "ar");
              CachedVariables.lang =
                  await CacheHelper.getData(key: CachedKeys.lang);
            }
          } else {
            final localization = EasyLocalization.of(context);
            if (localization != null) {
              context.setLocale(const Locale("en", ""));
              await CacheHelper.setData(key: CachedKeys.lang, value: "en");
              CachedVariables.lang =
                  await CacheHelper.getData(key: CachedKeys.lang);
            }
          }
        }
        if (state is SendLanguageErrorState) {
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
      },
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: AppColors.onPrimaryContainer,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              itemWidget(
                  text: 'English',
                  onTap: () async {
                    cubit.sendLanguage(isEnglish: true);
                  },
                  isSelected: cubit.isEnglish ? true : false),
              itemWidget(
                  text: 'العربية',
                  onTap: () async {
                    cubit.sendLanguage(isEnglish: false);
                  },
                  isSelected: cubit.isEnglish ? false : true)
            ],
          ),
        );
      },
    );
  }

  Widget itemWidget(
          {required String text,
          required void Function()? onTap,
          required bool isSelected}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: ShapeDecoration(
              shape: StadiumBorder(),
              color: isSelected ? AppColors.lemonColor : null),
          child: Text(
            text,
            style: GoogleFonts.inter(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp),
          ),
        ),
      );
}
