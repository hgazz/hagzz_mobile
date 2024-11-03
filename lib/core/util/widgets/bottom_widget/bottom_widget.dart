import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/loading_widget/loading_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class BottomWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final bool? isDisabled;
  final Widget? child;

  const BottomWidget(
      {super.key,
      required this.text,
      required this.onTap,
      this.width,
      this.child,
      this.height,
      this.isDisabled,
      this.textColor,
      this.backgroundColor,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    AppFunctions.logPrint(message: "Is Disabled: $isDisabled");
    return !isLoading
        ? FilledButton(
            onPressed: isDisabled != null
                ? null
                : () {
                    onTap!();
                  },
            style: FilledButton.styleFrom(
                backgroundColor: isDisabled == null
                    ? isLoading
                        ? AppColors.disableColor
                        : backgroundColor ?? AppColors.lemonColor
                    : AppColors.disableColor,
                minimumSize: Size(width ?? double.infinity, (height ?? 52).h),
                elevation: 0,
                shadowColor: AppColors.transparent,

                // foregroundColor: Colors.transparent,
                shape: StadiumBorder()),
            child: isLoading
                ? LoadingWidget()
                : child ??
                    CustomTextWidget(
                      text: text,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor ?? AppColors.black,
                    ))
        : SizedBox(
            width: double.infinity,
            height: (height ?? 52).h,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.white70,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: AppColors.white),
              ),
            ),
          );
  }
}
