import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors/app_colors.dart';
import '../../../constants/app_functions/app_functions.dart';

class TextWithFontSize14AndWeight500WithDynamicColorWidget
    extends StatelessWidget {
  final String? text;
  final bool isServer;
  final Color? color;
  final int maxLines;

  const TextWithFontSize14AndWeight500WithDynamicColorWidget(
      {super.key,
      required this.text,
      this.isServer = false,
      this.color,
      this.maxLines = 1});

  const TextWithFontSize14AndWeight500WithDynamicColorWidget.server(
      {super.key,
      required this.text,
      this.isServer = true,
      this.color,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Text(
            isServer
                ? text ?? ""
                : AppFunctions.translateText(
                    text: text ?? '', context: context),
            style: GoogleFonts.inter(
                height: 1,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: color ?? AppColors.onSurface),
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
          )
        : ShimmerWidget(width: 20.w, height: 20.h);
  }
}
