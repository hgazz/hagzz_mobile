import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_functions/app_functions.dart';

class LabelTextWidget extends StatelessWidget {
  final String text;
  final bool isBold;
  final bool isServer;
  final TextDecoration? textDecoration;
  final TextAlign? alignment;

  const LabelTextWidget(
      {super.key,
      required this.text,
      this.isBold = false,
      this.isServer = false,
      this.textDecoration = TextDecoration.none,
      this.alignment});

  const LabelTextWidget.server(
      {super.key,
      required this.text,
      this.isBold = false,
      this.isServer = true,
      this.textDecoration = TextDecoration.none,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return Text(
      isServer
          ? text
          : AppFunctions.translateText(text: text, context: context),
      textAlign: alignment,
      style: GoogleFonts.inter(
          color: AppColors.greyColor,
          fontSize: 12.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          decoration: textDecoration),
    );
  }
}
