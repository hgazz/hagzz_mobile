import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/widgets/text_widgets/text_with_font_size_12_and_w400_weight_black_color_widget/text_with_font_size_12_and_w500_weight_grey_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_functions/app_functions.dart';
import '../../constants/app_strings/app_strings.dart';
import '../svg_image_widget/svg_image_widget.dart';

class ShareOrReportItemWidget extends StatelessWidget {
  final bool isShare;

  const ShareOrReportItemWidget({super.key, required this.isShare});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (isShare) {
              AppFunctions.shareApp(context: context);
            } else {}
          },
          child: Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.black)),
            child: SVGImageWidget(
              image: isShare ? AppIcons.share : AppIcons.report,
              size: 15.w,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        TextWithFontSize12AndW400WeightBlackColorWidget(
            text: isShare ? AppStrings.shareProfile : AppStrings.report)
      ],
    );
  }
}
