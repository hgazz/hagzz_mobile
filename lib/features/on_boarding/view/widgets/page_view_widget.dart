import 'package:bookit/features/on_boarding/model/local_model/on_boarding_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../core/util/widgets/text_widgets/custom_text_widget.dart';

class PageViewWidget extends StatelessWidget {
  final OnBoardingObject object;

  const PageViewWidget({super.key, required this.object});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          object.path,
          height: 350.h,
        ),
        SizedBox(
          height: 30.h,
        ),
        Expanded(
          child: Container(
            width: 296.w,
            child: Column(
              children: [
                CustomTextWidget(
                  text: object.title,
                  textAlign: TextAlign.center,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                  maxLine: 2,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Expanded(
                  child: CustomTextWidget(
                    text: object.description,
                    fontSize: 16,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textGreyColor,
                    maxLine: 5,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
