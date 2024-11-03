import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;
  final bool isServer;
  final int maxLine;
  final TextDecoration? decoration;

  const CustomTextWidget(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      this.textAlign,
      this.isServer = false,
      this.maxLine = 1,
      this.decoration});

  const CustomTextWidget.server(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      this.textAlign,
      this.isServer = true,
      this.maxLine = 1,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(
      isServer
          ? text
          : AppFunctions.translateText(text: text, context: context),
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize.sp,
        decoration: decoration,
      ),
    );
  }
}
