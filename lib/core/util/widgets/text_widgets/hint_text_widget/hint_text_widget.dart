import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HintTextWidget extends StatelessWidget {
  final String text;
  final Color? color;

  const HintTextWidget({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppFunctions.translateText(text: text, context: context),
      style: GoogleFonts.inter(
        color: color ?? AppColors.lightGreyColor,
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
