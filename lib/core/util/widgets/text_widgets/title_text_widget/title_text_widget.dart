import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleTextWidget extends StatelessWidget {
  final String? text;
  final bool isServer;
  final int maxLines;

  const TitleTextWidget(
      {super.key,
      required this.text,
      this.isServer = false,
      this.maxLines = 1});

  const TitleTextWidget.server(
      {super.key, required this.text, this.isServer = true, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Text(
            isServer
                ? text ?? ''
                : AppFunctions.translateText(
                    text: text ?? '', context: context),
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),
          )
        : ShimmerWidget(width: 20.w, height: 20.h);
  }
}
