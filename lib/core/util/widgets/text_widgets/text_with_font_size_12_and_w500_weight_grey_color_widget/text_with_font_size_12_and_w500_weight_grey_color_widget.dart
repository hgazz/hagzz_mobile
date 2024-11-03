import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors/app_colors.dart';

class TextWithFontSize12AndW500WeightGreyColorWidget extends StatelessWidget {
  final String? text;
  final bool isServer;

  const TextWithFontSize12AndW500WeightGreyColorWidget(
      {super.key, required this.text, this.isServer = false});

  const TextWithFontSize12AndW500WeightGreyColorWidget.server(
      {super.key, required this.text, this.isServer = true});

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Text(
            isServer
                ? text ?? ''
                : AppFunctions.translateText(
                    text: text ?? '', context: context),
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: AppColors.textGreyColor))
        : ShimmerWidget(width: 20.w, height: 20.h);
  }
}
