import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBottomWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Color? textColor;
  final Widget? childText;
  final double? fontSize;

  const TextBottomWidget(
      {super.key,
      required this.text,
      required this.onTap,
      this.textColor,
      this.childText,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Text(
          AppFunctions.translateText(text: text, context: context),
          style: GoogleFonts.inter(
            color: textColor ?? Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: (fontSize ?? 15).sp,
          ),
        ));
  }
}
