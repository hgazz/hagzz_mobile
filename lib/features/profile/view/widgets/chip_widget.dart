import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/regular_with12_font_size_text/regular_with12_font_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChipWidget extends StatelessWidget {
  final String? text;
  final Color color;
  final Color textColor;
  final String? icon;
  final double height;
  final bool hasBorder;

  const ChipWidget(
      {super.key,
      required this.text,
      required this.color,
      required this.textColor,
      this.height = 28,
      this.icon,
      this.hasBorder = false});

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Container(
            height: height.h,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              color: color,
              shape: StadiumBorder(
                  side: hasBorder
                      ? const BorderSide(color: AppColors.greyBorderColor)
                      : BorderSide.none),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon != null
                    ? Container(
                        alignment: Alignment.center,
                        width: 16.w,
                        child: AppFunctions.determineIcon(icon ?? ''))
                    : SizedBox.shrink(),
                SizedBox(
                  width: 4.w,
                ),
                RegularWith12FontSizeText.server(
                  text: text ?? "",
                  color: textColor,
                ),
              ],
            ),
          )
        : ShimmerWidget(width: 40.w, height: height.h);
  }
}
