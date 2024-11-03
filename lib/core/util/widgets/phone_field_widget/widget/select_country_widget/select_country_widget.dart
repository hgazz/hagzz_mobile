import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_colors/app_colors.dart';
import '../../../../constants/app_images/app_images.dart';
import '../../../../constants/app_strings/app_strings.dart';
import '../../../text_widgets/custom_text_widget.dart';
import '../../../text_widgets/title_text_widget/title_text_widget.dart';

class SelectCountryWidget extends StatefulWidget {
  Function(String image)? onUserSelect;
  final bool isEgypt;

  SelectCountryWidget(
      {super.key, required this.onUserSelect, required this.isEgypt});

  @override
  State<SelectCountryWidget> createState() => _SelectCountryWidgetState();
}

class _SelectCountryWidgetState extends State<SelectCountryWidget> {
  bool isEgypt = true;

  @override
  void initState() {
    isEgypt = widget.isEgypt;
    super.initState();
  }

  void changeEgyptSelection(
      {required bool isEgypt, required String flagSelect}) {
    setState(() {
      this.isEgypt = isEgypt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 16.h,
        ),
        TitleTextWidget(text: AppStrings.selectCountry),
        SizedBox(
          height: 16.h,
        ),
        buildCountryItem(
            image: AppImages.egyptFlagSVG,
            nameAndCountryCode: AppStrings.egyptNameAndCountryCode,
            onTap: () {
              changeEgyptSelection(
                  isEgypt: true, flagSelect: AppImages.egyptFlagSVG);
              widget.onUserSelect!(AppImages.egyptFlagSVG);
            },
            isSelected: isEgypt),
        SizedBox(
          height: 8.h,
        ),
        buildCountryItem(
            image: AppImages.qatar,
            nameAndCountryCode: AppStrings.qatarNameAndCountryCode,
            onTap: () {
              changeEgyptSelection(isEgypt: false, flagSelect: AppImages.qatar);
              widget.onUserSelect!(AppImages.qatar);
            },
            isSelected: !isEgypt),
      ],
    );
  }

  Widget buildCountryItem(
          {required String image,
          required String nameAndCountryCode,
          required void Function()? onTap,
          required bool isSelected}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                  color: isSelected
                      ? AppColors.black
                      : AppColors.greyBorderColor)),
          child: Row(
            children: [
              SvgPicture.asset(image),
              SizedBox(
                width: 16.w,
              ),
              CustomTextWidget(
                  text: nameAndCountryCode,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black)
            ],
          ),
        ),
      );
}
