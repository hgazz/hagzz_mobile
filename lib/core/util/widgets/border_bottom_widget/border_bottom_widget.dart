import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors/app_colors.dart';

class BorderBottomWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double? height;

  const BorderBottomWidget(
      {super.key, required this.text, required this.onTap, this.height});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45.r),
                side: const BorderSide(color: AppColors.black)),
            minimumSize: Size(double.infinity, (height ?? 43).h)),
        child: Text(
          AppFunctions.translateText(text: text, context: context),
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ));
  }
}
