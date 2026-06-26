import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../constants/app_colors/app_colors.dart';

class PinOtpWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onComplete;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  const PinOtpWidget({
    super.key,
    required this.controller,
    required this.onComplete,
    this.onChange,
    this.onTap,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          controller: controller,
          length: 5,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\u0660-\u0669\u06F0-\u06F9]')),
          ],
          defaultPinTheme: PinTheme(
            width: 56.w,
            height: 56.h,
            textStyle: const TextStyle(fontSize: 22, color: Colors.black),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19.r),
              color: AppColors.surfaceContainer,
            ),
          ),
          separatorBuilder: (index) => const SizedBox(width: 8),
          validator: validator,
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          onCompleted: onComplete,
          onChanged: onChange,
          keyboardType: TextInputType.number,
          onTap: onTap,
          cursor: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 9),
                width: 22.w,
                height: 2.h,
                color: Colors.black,
              ),
            ],
          ),
          focusedPinTheme: PinTheme(
            width: 56.w,
            height: 56.h,
            textStyle: const TextStyle(fontSize: 22, color: Colors.black),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19.r),
              color: AppColors.surfaceContainer,
            ),
          ),
          submittedPinTheme: PinTheme(
            width: 56.w,
            height: 56.h,
            textStyle: const TextStyle(fontSize: 22, color: Colors.black),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19.r),
              color: AppColors.lemonColor,
            ),
          ),
          errorPinTheme: PinTheme(
            width: 56.w,
            height: 56.h,
            textStyle: const TextStyle(fontSize: 22, color: Colors.black),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19.r),
              color: AppColors.redColor,
            ),
          ),
        ),
      ),
    );
  }
}
