import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/widgets/text_widgets/medium_text_widget/medium_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderWidget extends StatelessWidget {
  final void Function() backOnPressed;
  final void Function()? trailingOnPressed;
  final String? trailingIcon;
  final String title;
  final bool? isShowBack;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;

  const HeaderWidget(
      {super.key,
      required this.backOnPressed,
      required this.title,
      this.trailingOnPressed,
      this.trailingIcon,
      this.isShowBack = true,
      this.titleFontSize,
      this.titleFontWeight});

  @override
  Widget build(BuildContext context) {
    // assert if trailing on pressed sent then trailing icon should not be null
    if (trailingOnPressed != null) {
      assert(trailingIcon != null && trailingIcon!.isNotEmpty,
          'trailingIcon should not be null or empty if trailingOnPressed is used');
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Row(
        children: [
          isShowBack ?? true
              ? InkWell(
                  onTap: backOnPressed,
                  child: Container(
                    height: 42.h,
                    width: 42.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.surfaceContainer,
                    ),
                    child: Icon(
                      Icons.arrow_back_outlined,
                      size: 24,
                    ),
                  ),
                )
              // Container(
              //         color: Colors.blue,
              //         child: IconButton.filledTonal(
              //             style: IconButton.styleFrom(
              //                 backgroundColor: AppColors.surfaceContainer,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(16.r),
              //                 )),
              //             onPressed: backOnPressed,
              //             icon: ),
              //       )
              : SizedBox.shrink(),
          if (isShowBack ?? true)
            SizedBox(
              width: 10.w,
            ),
          Expanded(
            child: MediumTextWidget(
              text: title,
              fontSize: titleFontSize ?? 20,
              fontWeight: titleFontWeight,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          if (trailingIcon != null)
            IconButton.filledTonal(
                style: IconButton.styleFrom(
                    minimumSize: Size(42.w, 42.h),
                    backgroundColor: AppColors.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    )),
                onPressed: trailingOnPressed,
                icon: SvgPicture.asset(trailingIcon!)),
        ],
      ),
    );
  }
}
