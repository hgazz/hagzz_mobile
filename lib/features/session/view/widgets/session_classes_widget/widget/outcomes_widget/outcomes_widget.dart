import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';

class OutcomesWidget extends StatelessWidget {
  final List<String> outcomes;

  const OutcomesWidget({super.key, required this.outcomes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: AppStrings.outcomes,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
          SizedBox(
            height: 16.h,
          ),
          for (var i = 0; i < outcomes.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.checkmark_alt,
                  color: AppColors.greyColor,
                  size: 20.r,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: CustomTextWidget.server(
                    text: outcomes[i].toString() ?? "",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            if (i != outcomes.length - 1)
              SizedBox(
                height: 8.h,
              ),
          ],
        ],
      ),
    );
  }
}
