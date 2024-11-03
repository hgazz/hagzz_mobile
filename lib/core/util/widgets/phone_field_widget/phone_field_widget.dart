import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/form_field_Widget/form_field_widget.dart';
import 'package:bookit/core/util/widgets/phone_field_widget/widget/select_country_widget/select_country_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_images/app_images.dart';
import '../../constants/app_validators/app_validators.dart';

class PhoneFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  void Function(String countryCode) getCountryCode;

  PhoneFieldWidget({
    super.key,
    required this.controller,
    required this.getCountryCode,
  });

  @override
  State<PhoneFieldWidget> createState() => _PhoneFieldWidgetState();
}

class _PhoneFieldWidgetState extends State<PhoneFieldWidget> {
  String flagSelect = AppImages.egyptFlagSVG;

  @override
  Widget build(BuildContext context) {
    return FormFieldWidget(
        controller: widget.controller,
        hintText: AppStrings.enterYourPhoneNumber,
        keyInputType: TextInputType.phone,
        prefix: InkWell(
          onTap: () {
            AppFunctions.showBottomSheet(
                context: context,
                height: MediaQuery.of(context).size.height * 0.35,
                child: SelectCountryWidget(
                  onUserSelect: (value) {
                    setState(() {
                      flagSelect = value;
                      widget.getCountryCode(
                          value == AppImages.egyptFlagSVG ? "+2" : "+974");
                    });
                    AppFunctions.popNavigate(context: context);
                  },
                  isEgypt: flagSelect == AppImages.egyptFlagSVG ? true : false,
                ));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(flagSelect),
                SizedBox(
                  width: 12.w,
                ),
                Container(
                  width: 1,
                  height: 31.h,
                  color: AppColors.outlineVariant,
                )
              ],
            ),
          ),
        ),
        validator: (value) {
          return AppValidator.phoneValidator(
              value: value,
              context: context,
              isEgypt: flagSelect == AppImages.egyptFlagSVG ? true : false);
        });
  }
}
