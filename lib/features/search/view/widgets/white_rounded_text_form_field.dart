import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/util/constants/app_colors/app_colors.dart';

class WhiteRoundedTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final BorderSide? borderSide;
  final List<TextInputFormatter>? inputFormatters;

  final TextInputType keyboardType;
  final String hintText;
  final bool readOnly;
  final String? prefix;
  final Widget? prefixIcon;
  final TextAlign textAlign;

  final void Function()? onTab;

  final void Function(String)? onChanged;

  const WhiteRoundedTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    this.borderSide,
    required this.keyboardType,
    required this.hintText,
    this.readOnly = false,
    this.inputFormatters,
    this.onTab,
    this.onChanged,
    this.prefix,
    this.prefixIcon,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 400.w,
        maxHeight: 60.h,
        minHeight: 54.h,
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: textAlign,
        onChanged: onChanged,
        onTap: onTab,
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: keyboardType == TextInputType.visiblePassword,
        decoration: InputDecoration(
          // prefix: prefix,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 60,
            // maxHeight: 100,
          ),
          prefixIcon: prefixIcon,
          prefixText: prefix,
          // prefixStyle: AppTextStyle.materialThemeBodyLarge,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 30.h,
          ),
          hintStyle: GoogleFonts.inter(
            color: AppColors.lightGreyColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          // filled: true,
          // fillColor: AppColors.whiteColor,
          border: OutlineInputBorder(
            borderSide: borderSide ?? BorderSide.none,
            borderRadius: BorderRadius.circular(50.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: borderSide ?? BorderSide.none,
            borderRadius: BorderRadius.circular(50.r),
          ),
          hintText: hintText,
          //todo add hint style
          // hintStyle: AppTextStyle.materialThemeBodyLarge,
        ),
      ),
    );
  }
}
