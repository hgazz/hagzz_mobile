import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors/app_colors.dart';
import '../text_widgets/custom_text_widget.dart';

class MyErrorWidget extends StatelessWidget {
  final Function()? onPressed;
  const MyErrorWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextWidget(
          text: 'Something went wrong!',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        if (onPressed != null) ...[
          SizedBox(
            height: 16.h,
          ),
          FilledButton(onPressed: onPressed, child: Text('Retry')),
        ]
      ],
    );
  }
}
