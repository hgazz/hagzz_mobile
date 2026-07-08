import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/form_field_Widget/form_field_widget.dart';
import 'package:bookit/core/util/widgets/phone_field_widget/widget/select_country_widget/select_country_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_validators/app_validators.dart';

class PhoneFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String countryCode) getCountryCode;

  const PhoneFieldWidget({
    super.key,
    required this.controller,
    required this.getCountryCode,
  });

  @override
  State<PhoneFieldWidget> createState() => _PhoneFieldWidgetState();
}

class _PhoneFieldWidgetState extends State<PhoneFieldWidget> {
  Country selectedCountry = countries.firstWhere(
    (country) => country.code == 'EG',
  );

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
                height: MediaQuery.of(context).size.height * 0.78,
                child: SelectCountryWidget(
                  onUserSelect: (country) {
                    setState(() {
                      selectedCountry = country;
                      widget.getCountryCode('+${country.fullCountryCode}');
                    });
                    AppFunctions.popNavigate(context: context);
                  },
                  selectedCountryCode: selectedCountry.code,
                ));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(selectedCountry.flag,
                    style: TextStyle(fontSize: 24.sp)),
                SizedBox(width: 6.w),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    '+${selectedCountry.fullCountryCode}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ),
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
            minLength: selectedCountry.minLength,
            maxLength: selectedCountry.maxLength,
          );
        });
  }
}
