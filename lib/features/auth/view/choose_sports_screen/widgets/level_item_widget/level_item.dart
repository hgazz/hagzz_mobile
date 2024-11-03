import 'package:bookit/features/auth/model/local_model/level_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../../core/util/widgets/text_widgets/regular_with12_font_size_text/regular_with12_font_size_text.dart';

class LevelItem extends StatelessWidget {
  final void Function()? onTap;
  final LevelModel data;
  final bool isChoose;

  const LevelItem(
      {super.key,
      required this.onTap,
      required this.data,
      required this.isChoose});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color:
                // isChoose
                //     ? AppColors.lemonColor
                //     :
                AppColors.greyWithOpacityColor),
        child: Row(
          children: [
            SvgPicture.asset(
              data.image,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(
              width: 4.w,
            ),
            !isChoose
                ? RegularWith12FontSizeText(
                    text: data.name, color: AppColors.black)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
