import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_strings/app_strings.dart';
import '../../widgets/text_widgets/custom_text_widget.dart';

class ChooseVerificationTypeComponent extends StatefulWidget {
  final void Function(bool isWhatsapp) getSelected;

  const ChooseVerificationTypeComponent({super.key, required this.getSelected});

  @override
  State<ChooseVerificationTypeComponent> createState() =>
      _ChooseVerificationTypeComponentState();
}

class _ChooseVerificationTypeComponentState
    extends State<ChooseVerificationTypeComponent> {
  String verificationType = "whatsapp";

  void changeSelected({required String type}) {
    setState(() {
      verificationType = type;
    });
    widget.getSelected(type == "whatsapp" ? true : false);
  }

  @override
  void initState() {
    widget.getSelected(verificationType == "whatsapp" ? true : false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: AppStrings.sendCodeVia,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.greyColor,
        ),
        SizedBox(
          height: 16.h,
        ),
        Row(
          children: [
            //whatsapp
            Radio<String>(
              value: "whatsapp",
              groupValue: verificationType,
              activeColor: AppColors.lemonColor,
              onChanged: (value) {
                changeSelected(type: value ?? "whatsapp");
              },
            ),
            CustomTextWidget(
              text: AppStrings.whatsapp,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.greyColor,
            ),
            Radio<String>(
              activeColor: AppColors.lemonColor,
              value: 'sms',
              groupValue: verificationType,
              onChanged: (value) {
                changeSelected(type: value ?? "sms");
              },
            ),

            CustomTextWidget(
              text: AppStrings.sms,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.greyColor,
            ),
          ],
        ),
      ],
    );
  }
}
