import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetWidget extends StatelessWidget {
  final String? title;
  final Widget child;

  final double? height;

  const BottomSheetWidget(
      {super.key, this.title, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? MediaQuery.of(context).size.height * 0.80,

      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          )),
      // constraints: BoxConstraints(
      //   maxHeight: MediaQuery.of(context).size.height * 0.8,
      // ),
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 108,
              height: 5,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: ShapeDecoration(
                color: AppColors.greyColor,
                shape: StadiumBorder(),
              ),
            ),
            if (title != null) ...[
              CustomTextWidget(
                text: title!,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              SizedBox(
                height: 16.h,
              )
            ],
            child
          ],
        ),
      ),
    );
  }
}
