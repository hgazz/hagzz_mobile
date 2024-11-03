import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/phone_field_widget/phone_field_widget.dart';
import 'package:bookit/features/auth/view_model/register_cubit/register_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../../core/util/constants/app_icons/app_icons.dart';
import '../../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../../core/util/constants/app_validators/app_validators.dart';
import '../../../../../../core/util/widgets/address_widget/view/address_widget.dart';
import '../../../../../../core/util/widgets/form_field_Widget/form_field_widget.dart';
import '../../../../../../core/util/widgets/radio_widget/radio_widget.dart';
import '../../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';

class UserFormDataWidget extends StatelessWidget {
  const UserFormDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormFieldWidget(
                validator: (value) => AppValidator.generalValidator(
                    value: value ?? '', context: context),
                keyInputType: TextInputType.text,
                controller: cubit.nameController,
                hintText: AppStrings.enterName,
                // onChange: (value) {
                //   cubit.checkUserDataChanges(context: context);
                // },
                prefix: SvgPicture.asset(
                  AppIcons.profileOutlined,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                      AppColors.greyBorderColor, BlendMode.srcIn),
                ),
                prefixFocused: SvgPicture.asset(
                  AppIcons.profileOutlined,
                  fit: BoxFit.scaleDown,
                  colorFilter:
                      ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              PhoneFieldWidget(
                controller: cubit.phoneController,
                getCountryCode: (value) {
                  cubit.changeCountryCode(value);
                },
              ),
              if (cubit.validationError != null)
                CustomTextWidget(
                    text: cubit.validationError ?? '',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.redColor),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  RadioWidget(
                    isValidationError:
                        cubit.genderValidation != null ? true : false,
                    isSelected: cubit.isMale ?? false,
                    icon: Icons.face,
                    text: AppStrings.male,
                    onTap: () {
                      cubit.changeGender(true);
                    },
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  RadioWidget(
                    isValidationError:
                        cubit.genderValidation != null ? true : false,
                    isSelected: cubit.isMale != null ? !cubit.isMale! : false,
                    icon: Icons.face_4,
                    text: AppStrings.female,
                    onTap: () {
                      cubit.changeGender(false);
                    },
                  ),
                ],
              ),
              cubit.genderValidation != null
                  ? Text(
                      "*${cubit.genderValidation!}",
                      style: GoogleFonts.inter(
                        color: Colors.red,
                        fontSize: 12.sp,
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 16.h,
              ),
              FormFieldWidget(
                // validator: (value) => AppValidator.generalValidator(
                //     value: value ?? '', context: context),
                validator: (value) => null,
                keyInputType: TextInputType.none,

                enableInteractive: false,
                // onChange: (value) {
                //   cubit.checkUserDataChanges(context: context);
                // },
                onTap: () async {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => Container(
                      height: 216,
                      padding: const EdgeInsets.only(top: 6.0),
                      // The Bottom margin is provided to align the popup above the system
                      // navigation bar.
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      // Provide a background color for the popup.
                      color:
                          CupertinoColors.systemBackground.resolveFrom(context),
                      // Use a SafeArea widget to avoid system overlaps.
                      child: SafeArea(
                        top: false,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          minimumDate: DateTime(1960),
                          maximumDate: DateTime(2018, 12, 31),
                          initialDateTime: DateTime(2005, 1, 1),
                          onDateTimeChanged: (DateTime value) {
                            cubit.dateController.text =
                                value.toString().split(" ")[0];
                            // cubit.checkUserDataChanges(context: context);
                          },
                        ),
                      ),
                    ),
                  );
                },
                controller: cubit.dateController,
                hintText: "DD / MM / YYYY",
                prefix: SvgPicture.asset(
                  AppIcons.birthDate,
                  fit: BoxFit.scaleDown,
                ),
                prefixFocused: SvgPicture.asset(
                  AppIcons.birthDate,
                  colorFilter:
                      ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),

              // ChooseCountryWidget(),
              AddressWidget(
                isValued: true,
              ),

              SizedBox(
                height: 24.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Checkbox(
                        activeColor: AppColors.black,
                        checkColor: AppColors.white,
                        splashRadius: 0,
                        value: cubit.isAgree ?? false,
                        onChanged: (value) {
                          cubit.changeAgreeTermsAndCondition();
                        }),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                      child: RichText(
                          text: TextSpan(children: [
                    TextSpan(
                        text: AppFunctions.translateText(
                            text: AppStrings.iAgreeTo, context: context),
                        style: GoogleFonts.inter(
                          color: AppColors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        )),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            AppFunctions.namedNavigateTo(
                                context: context,
                                navigatedScreen: RouteConstants.privacyPolicy);
                          },
                        text: AppFunctions.translateText(
                            text: AppStrings.privacyPolicy, context: context),
                        style: GoogleFonts.inter(
                            color: AppColors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline)),
                    TextSpan(
                        text: ", ",
                        style: GoogleFonts.inter(
                          color: AppColors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        )),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            AppFunctions.namedNavigateTo(
                                context: context,
                                navigatedScreen:
                                    RouteConstants.termsAndConditions);
                          },
                        text: AppFunctions.translateText(
                            text: AppStrings.termsAndConditions,
                            context: context),
                        style: GoogleFonts.inter(
                            color: AppColors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline)),
                  ]))),

                  // const Expanded(
                  //     child:
                  //         TextWithFontSize14AndWeight500WithDynamicColorWidget(
                  //   text: AppStrings.termsAndConditions,
                  //   color: AppColors.black,
                  //   maxLines: 2,
                  // ))
                ],
              ),
              cubit.agreementValidation != null
                  ? Text(
                      "*${cubit.agreementValidation!}",
                      style: GoogleFonts.inter(
                        color: Colors.red,
                        fontSize: 12.sp,
                      ),
                    )
                  : SizedBox.shrink(),

              SizedBox(
                height: 16.h,
              ),
              // ChooseVerificationTypeComponent(
              //   getSelected: (value) {
              //     cubit.changeSelectedVerificationType(isWhatsApp: value);
              //   },

              // ),
            ],
          ),
        );
      },
    );
  }
}
