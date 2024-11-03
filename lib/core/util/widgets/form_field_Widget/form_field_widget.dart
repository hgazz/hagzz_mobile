import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors/app_colors.dart';

class FormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixFocused;
  final TextInputType keyInputType;
  final void Function()? onTap;
  final void Function(String)? onChange;
  final bool readOnly;
  final bool enableInteractive;
  final String? Function(String?)? validator;
  final int maxLines;
  final int? maxLength;

  FormFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.prefixIcon,
      this.maxLength,
      this.prefix,
      required this.keyInputType,
      required this.validator,
      this.onTap,
      this.maxLines = 1,
      this.onChange,
      this.suffix,
      this.readOnly = false,
      this.enableInteractive = true,
      this.prefixFocused});

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  var borderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.r),
      borderSide: const BorderSide(color: AppColors.lightGreyColor));

  var errorBorderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.r),
      borderSide: const BorderSide(color: AppColors.redColor));

  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyInputType,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      onChanged: widget.onChange,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      focusNode: _focusNode,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      enableInteractiveSelection: widget.enableInteractive,
      decoration: InputDecoration(
          hintText: AppFunctions.translateText(
              text: widget.hintText, context: context),
          hintStyle: GoogleFonts.inter(
            color: AppColors.lightGreyColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
          prefixIconConstraints:
              BoxConstraints(maxWidth: 60.w, minHeight: 50.h, minWidth: 50.w),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: AppColors.greyColor,
                )
              : isFocused
                  ? widget.prefixFocused ?? widget.prefix
                  : widget.prefix,
          // counterText: "0/500",
          border: borderDecoration,
          suffixIcon: widget.suffix,
          enabledBorder: borderDecoration,
          focusedBorder: borderDecoration.copyWith(
              borderSide: BorderSide(color: AppColors.black)),
          errorBorder: errorBorderDecoration),
    );
  }
}
