import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';

class LeaveItemWidget extends StatelessWidget {
  final bool isSelected;
  final void Function(bool?)? onChanged;
  final String text;

  const LeaveItemWidget({
    super.key,
    required this.isSelected,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: isSelected,
          onChanged: onChanged,
          activeColor: AppColors.lemonColor,
        ),
        Expanded(
          child: CustomTextWidget(
              text: text,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textGreyColor),
        )
      ],
    );
  }
}
