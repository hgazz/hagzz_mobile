import 'package:bookit/core/util/widgets/address_widget/model/address_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/app_functions/app_functions.dart';
import '../../constants/app_icons/app_icons.dart';
import '../../constants/app_validators/app_validators.dart';

class DropDownWidget extends StatefulWidget {
  final List<AddressModel> listOfDropDown;
  final AddressModel? selectedValue;
  void Function(AddressModel selectedValue) getSelected;
  String? label;

  DropDownWidget(
      {super.key,
      required this.listOfDropDown,
      required this.getSelected,
      this.label,
      this.selectedValue});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  var borderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.r),
      borderSide: const BorderSide(color: AppColors.lightGreyColor));
  var errorBorderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.r),
      borderSide: const BorderSide(color: AppColors.redColor));

  DropdownStyleData dropdownStyleData = DropdownStyleData(
    maxHeight: 250.h,
    elevation: 1423256789076588888,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: AppColors.surfaceContainer.withOpacity(0.9999),
        backgroundBlendMode: BlendMode.src,
        border: Border.all(color: AppColors.greyBorderColor)),
  );

  var textStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 14.sp, color: AppColors.black);

  var contentPadding = EdgeInsets.symmetric(horizontal: 10.r, vertical: 16.h);
  var iconStyle = IconStyleData(
      icon: SvgPicture.asset(
        AppIcons.arrowDown,
        fit: BoxFit.scaleDown,
        height: 24,
        width: 24,
      ),
      iconEnabledColor: AppColors.black,
      iconDisabledColor: AppColors.greenColor);

  AddressModel? selectedValue;

  changeSelectedValue(AddressModel address) {
    setState(() {
      selectedValue = address;
    });
    widget.getSelected(address);
  }

  @override
  void initState() {
    if (widget.selectedValue != null) {
      changeSelectedValue(
          widget.selectedValue ?? AddressModel(id: 0, name: ""));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppFunctions.logPrint(message: "My Selected: : ${widget.selectedValue}");
    return DropdownButtonFormField2<AddressModel>(
        onChanged: (AddressModel? value) {
          changeSelectedValue(value!);
        },
        hint: Text(
          selectedValue != null
              ? selectedValue?.name ?? ''
              : AppFunctions.translateText(
                  text: widget.label ?? '', context: context),
          style: textStyle.copyWith(
              color: selectedValue != null
                  ? AppColors.black
                  : AppColors.outlineVariant),
        ),
        // value: selectedValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return AppValidator.generalValidator(
              value: selectedValue?.name ?? '', context: context);
        },
        isExpanded: true,
        isDense: false,
        iconStyleData:
            const IconStyleData(icon: Icon(Icons.keyboard_arrow_down)),
        dropdownStyleData: dropdownStyleData,
        style: textStyle,
        decoration: InputDecoration(
          // labelText: AppFunctions.translateText(
          //     text: widget.label ?? '', context: context),
          labelStyle: textStyle.copyWith(
              color: selectedValue != null
                  ? AppColors.black
                  : AppColors.outlineVariant),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: contentPadding,
          enabledBorder: borderDecoration,
          focusedBorder: borderDecoration.copyWith(
              borderSide: BorderSide(color: AppColors.lemonColor)),
          errorBorder: errorBorderDecoration,
          border: borderDecoration,
        ),
        items: widget.listOfDropDown
            .map((e) => DropdownMenuItem(value: e, child: Text(e.name ?? '')))
            .toList());
  }
}
