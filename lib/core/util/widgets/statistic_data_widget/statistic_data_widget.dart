import 'package:bookit/core/util/widgets/shimmer_widget/shimmer_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/text_with_font_size_12_and_w500_weight_grey_color_widget/text_with_font_size_12_and_w500_weight_grey_color_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticDataWidget extends StatelessWidget {
  final int? number;
  final String? text;

  const StatisticDataWidget(
      {super.key, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        number != null
            ? TextWithFontSize12AndW500WeightGreyColorWidget.server(
                text: number.toString())
            : ShimmerWidget(width: 20.w, height: 20.w),
        text != null
            ? TextWithFontSize12AndW500WeightGreyColorWidget(text: text ?? '')
            : ShimmerWidget(width: 20.w, height: 20.w),
      ],
    );
  }
}
