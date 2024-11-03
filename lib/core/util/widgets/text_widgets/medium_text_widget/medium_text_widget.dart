import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_functions/app_functions.dart';

class MediumTextWidget extends StatelessWidget {
  final String? text;
  final bool isServer;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const MediumTextWidget(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.isServer = false,
      this.fontWeight});

  const MediumTextWidget.server(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.isServer = true,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Text(
            isServer
                ? text ?? ''
                : AppFunctions.translateText(
                    text: text ?? '', context: context),
            style: GoogleFonts.inter(
              color: color ?? Colors.black,
              fontWeight: fontWeight ?? FontWeight.w600,
              fontSize: (fontSize ?? 22).sp,
            ),
          )
        : ShimmerWidget(width: 20.w, height: 20.h);
  }
}
