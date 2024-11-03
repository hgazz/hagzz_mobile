import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/local_models/empty_model_data/empty_model.dart';

class EmptyWidget extends StatelessWidget {
  final EmptyModel data;

  const EmptyWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 316.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 29.5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: (data.isFollowing ?? false ? 16 : 80).h),
            SvgPicture.asset(
              data.image,
            ),
            SizedBox(height: 24.h),
            Column(
              children: [
                CustomTextWidget(
                  text: data.title,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                  textAlign: TextAlign.center,
                  maxLine: 2,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextWidget(
                  text: data.description,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  textAlign: TextAlign.center,
                  maxLine: 2,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
