import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_images/app_images.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/svg_image_widget/svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/helper/cach/cached_variables.dart';
import '../../../core/helper/router/rout_constants.dart';
import '../../../core/util/constants/app_functions/app_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color backgroundColor = AppColors.black;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      AppFunctions.namedNavigateAndFinishTo(
          context: context, navigatedScreen: determineNavigatedScreen());
    });
  }

  String determineNavigatedScreen() {
    // CachedVariables.onBoard = RouteConstants.onBoarding;
    AppFunctions.logPrint(message: "Tokeeen: ${CachedVariables.onBoard}");
    if (CachedVariables.token == null) {
      return RouteConstants.onBoarding;
    } else if (CachedVariables.token != null) {
      return RouteConstants.bottomNavBar;
    } else {
      return RouteConstants.onBoarding;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: SVGImageWidget(
                    image: AppImages.hagzz,
                    size: 150.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppFunctions.translateText(
                          text: AppStrings.poweredBy, context: context),
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: 12.sp,
                          color: AppColors.whiteBackground),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    SVGImageWidget(image: AppImages.poweredBy),
                    SizedBox(
                      width: 4.w,
                    ),
                    SVGImageWidget(
                      image: AppImages.payTechEG,
                      size: 70.w,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
