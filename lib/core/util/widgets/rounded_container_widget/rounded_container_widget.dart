import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/widgets/svg_image_widget/svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedContainerWidget extends StatelessWidget {
  final String image;
  final void Function()? onTap;
  final bool hasNotify;

  const RoundedContainerWidget({
    super.key,
    required this.image,
    required this.onTap,
    this.hasNotify = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 42.w,
        height: 42.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        margin: EdgeInsets.only(
            right: CachedVariables.lang != "ar" ? 10.w : 0,
            top: 2.h,
            bottom: 2.h,
            left: CachedVariables.lang == "ar" ? 10.w : 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: AppColors.surfaceContainer),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            SVGImageWidget(image: image),
            hasNotify
                ? CircleAvatar(
                    radius: 3.r,
                    backgroundColor: AppColors.redColor,
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
