import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/app_colors/app_colors.dart';

class DotIndicatorWidget extends StatelessWidget {
  final int currentIndex;
  final int count;
  final IndicatorEffect? effect;

  const DotIndicatorWidget(
      {super.key,
      required this.currentIndex,
      required this.count,
      this.effect});

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: currentIndex,
      count: count,
      effect: effect ??
          WormEffect(
            activeDotColor: AppColors.lemonColor,
            dotColor: AppColors.dotsColor,
            type: WormType.underground,
            dotWidth: 8.w,
            dotHeight: 8.h,
            strokeWidth: 8.w,
            spacing: 6.w,
          ),
    );
  }
}
