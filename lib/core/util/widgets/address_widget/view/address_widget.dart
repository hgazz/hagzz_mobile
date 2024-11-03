import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/address_widget/model/address_model.dart';
import 'package:bookit/core/util/widgets/address_widget/view_model/address_cubit.dart';
import 'package:bookit/core/util/widgets/loading_widget/loading_widget.dart';
import 'package:bookit/features/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors/app_colors.dart';
import '../../../constants/app_icons/app_icons.dart';
import '../../../constants/app_strings/app_strings.dart';

class AddressWidget extends StatefulWidget {
  final bool isValued;

  AddressWidget({super.key, this.isValued = false});

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
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

  @override
  void initState() {
    AddressCubit.get(context).getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AddressCubit.get(context);
        return Column(
          children: [
            AnimatedConditionalBuilder(
                condition: cubit.countries.isNotEmpty,
                builder: (context) => DropdownButtonFormField2<AddressModel>(
                    onChanged: (AddressModel? value) {
                      cubit.changeSelectedCountry(value!);
                      EditProfileCubit.get(context)
                          .checkUserDataChanges(context: context);
                    },
                    // value: isValued ? cubit.selectedCountry : null,
                    hint: Text(
                      cubit.selectedCountry != null
                          ? cubit.selectedCountry?.name ?? ''
                          : AppFunctions.translateText(
                              text: AppStrings.selectYourCountry,
                              context: context),
                      style: textStyle.copyWith(
                          color: cubit.selectedCountry != null
                              ? AppColors.black
                              : AppColors.outlineVariant),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    iconStyleData: iconStyle,
                    validator: (value) {
                      if (cubit.selectedCountry == null) {
                        return AppFunctions.translateText(
                            text: AppStrings.countryValidation,
                            context: context);
                      }
                      return null;
                    },
                    dropdownStyleData: dropdownStyleData,
                    style: textStyle,
                    decoration: InputDecoration(
                      contentPadding: contentPadding,
                      enabledBorder: borderDecoration,
                      focusedBorder: borderDecoration.copyWith(
                          borderSide: BorderSide(color: AppColors.black)),
                      errorBorder: errorBorderDecoration,
                      border: borderDecoration,
                    ),
                    items: cubit.countries
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.name ?? '')))
                        .toList()),
                fallback: (context) => const LoadingWidget()),
            if (cubit.selectedCountry != null)
              SizedBox(
                height: 16.h,
              ),
            AnimatedConditionalBuilder(
                condition: cubit.selectedCountry != null,
                builder: (context) => DropdownButtonFormField2<AddressModel>(
                    onChanged: (AddressModel? value) {
                      cubit.changeSelectedCity(value!);
                      EditProfileCubit.get(context)
                          .checkUserDataChanges(context: context);
                    },
                    value: widget.isValued ? cubit.selectedCity : null,
                    hint: Text(
                        cubit.selectedCity != null
                            ? cubit.selectedCity?.name ?? ''
                            : AppFunctions.translateText(
                                text: AppStrings.chooseCity, context: context),
                        style: textStyle.copyWith(
                            color: cubit.selectedCity != null
                                ? AppColors.black
                                : AppColors.outlineVariant)),
                    iconStyleData: iconStyle,
                    decoration: InputDecoration(
                      contentPadding: contentPadding,
                      enabledBorder: borderDecoration,
                      focusedBorder: borderDecoration.copyWith(
                          borderSide: BorderSide(color: AppColors.black)),
                      errorBorder: errorBorderDecoration,
                      border: borderDecoration,
                    ),
                    style: textStyle,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (cubit.selectedCity == null) {
                        return AppFunctions.translateText(
                            text: AppStrings.cityValidation, context: context);
                      }
                      return null;
                    },
                    dropdownStyleData: dropdownStyleData,
                    items: cubit.cities
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.name ?? '')))
                        .toList()),
                fallback: (context) => SizedBox.shrink()),
            if (cubit.selectedCity != null)
              SizedBox(
                height: 16.h,
              ),
            AnimatedConditionalBuilder(
                condition: cubit.selectedCity != null,
                builder: (context) => DropdownButtonFormField2<AddressModel>(
                    onChanged: (AddressModel? value) {
                      cubit.changeSelectedArea(value!);
                      EditProfileCubit.get(context)
                          .checkUserDataChanges(context: context);
                    },
                    value: widget.isValued ? cubit.selectedArea : null,
                    hint: Text(
                        cubit.selectedArea != null
                            ? cubit.selectedArea?.name ?? ''
                            : AppFunctions.translateText(
                                text: AppStrings.chooseArea, context: context),
                        style: textStyle.copyWith(
                            color: cubit.selectedArea != null
                                ? AppColors.black
                                : AppColors.outlineVariant)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    iconStyleData: iconStyle,
                    validator: (value) {
                      if (cubit.selectedArea == null) {
                        return AppFunctions.translateText(
                            text: AppStrings.areaValidation, context: context);
                      }
                      return null;
                    },
                    style: textStyle,
                    dropdownStyleData: dropdownStyleData,
                    decoration: InputDecoration(
                      contentPadding: contentPadding,
                      enabledBorder: borderDecoration,
                      focusedBorder: borderDecoration.copyWith(
                          borderSide: BorderSide(color: AppColors.black)),
                      errorBorder: errorBorderDecoration,
                      border: borderDecoration,
                    ),
                    items: cubit.areas
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text(e.name ?? '')))
                        .toList()),
                fallback: (context) => SizedBox.shrink())
          ],
        );
      },
    );
  }
}
