import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegularWith12FontSizeText extends StatelessWidget {
  final String? text;
  final Color color;
  final bool isServer;

  const RegularWith12FontSizeText(
      {super.key,
      required this.text,
      required this.color,
      this.isServer = false});

  const RegularWith12FontSizeText.server(
      {super.key,
      required this.text,
      required this.color,
      this.isServer = true});

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Text(
            isServer
                ? text ?? ''
                : AppFunctions.translateText(
                    text: text ?? '', context: context),
            style: GoogleFonts.inter(
              fontWeight: FontWeight.normal,
              fontSize: 11.sp,
              color: color,
            ),
          )
        : ShimmerWidget(width: 20.w, height: 20.h);
  }
}
