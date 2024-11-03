import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';

class DateTimeWidget extends StatelessWidget {
  final String date;
  final String time;

  const DateTimeWidget({super.key, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CustomTextWidget.server(
            text: AppFunctions.formatDateTimeFromStringForSessionDetails(
                date: date),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Center(
          child: CustomTextWidget.server(
            text: time,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
