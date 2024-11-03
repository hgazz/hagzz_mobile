import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../svg_image_widget/svg_image_widget.dart';
import '../text_widgets/text_with_font_size_12_and_w500_weight_grey_color_widget/text_with_font_size_12_and_w500_weight_grey_color_widget.dart';

class RowContainIconAndTextWidget extends StatelessWidget {
  final String? icon;
  final String? text;

  const RowContainIconAndTextWidget(
      {super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return !(icon?.contains("rate.svg") ?? false)
        ? Row(
            children: [
              icon != null
                  ? SVGImageWidget(image: icon!)
                  : ShimmerWidget(
                      width: 20.w,
                      height: 20.h,
                      containerShape: BoxShape.circle,
                    ),
              SizedBox(
                width: 5.w,
              ),
              TextWithFontSize12AndW500WeightGreyColorWidget.server(
                  text: text ?? '')
            ],
          )
        : SizedBox.shrink();
  }
}
