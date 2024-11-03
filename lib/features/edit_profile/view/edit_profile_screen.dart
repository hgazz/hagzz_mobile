import 'package:bookit/core/util/models/api_models/user_model/user_model.dart';
import 'package:bookit/features/edit_profile/view/widgets/edit_profile_bottoms_widget/edit_profile_bottoms_widget.dart';
import 'package:bookit/features/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/helper/cach/cached_variables.dart';
import '../../../core/util/constants/app_colors/app_colors.dart';
import '../../../core/util/constants/app_functions/app_functions.dart';
import '../../../core/util/constants/app_icons/app_icons.dart';
import '../../../core/util/constants/app_strings/app_strings.dart';
import '../../../core/util/constants/app_validators/app_validators.dart';
import '../../../core/util/widgets/address_widget/view/address_widget.dart';
import '../../../core/util/widgets/form_field_Widget/form_field_widget.dart';
import '../../../core/util/widgets/radio_widget/radio_widget.dart';
import '../../../core/util/widgets/user_image_widget/user_image_widget.dart';
import '../../profile/view/widgets/header_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    EditProfileCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        var cubit = EditProfileCubit.get(context);

        if (state is GetUserProfileDataSuccessState) {
          cubit.assignDataToController(
              data: cubit.userModel?.data?.profile ?? Profile(),
              context: context);
        }
      },
      builder: (context, state) {
        var cubit = EditProfileCubit.get(context);
        return SafeArea(
          child: Column(
            children: [
              HeaderWidget(
                backOnPressed: () {
                  cubit.profileHasChanges = false;
                  AppFunctions.popNavigate(context: context);
                },
                // todo : choose the right title depend on the localization
                title: AppStrings.editProfile,
              ),
              SizedBox(
                height: 16.h,
              ),
              Expanded(
                child: Form(
                  key: cubit.formKey,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      UserImageWidget(
                        getImage: (image) async {
                          cubit.getImage(image: image);
                        },
                        url: cubit.userImage,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      FormFieldWidget(
                        validator: (value) => AppValidator.generalValidator(
                            value: value ?? '', context: context),
                        keyInputType: TextInputType.text,
                        controller: cubit.nameController,
                        hintText: AppStrings.enterName,
                        onChange: (value) {
                          cubit.checkUserDataChanges(context: context);
                        },
                        prefix: SvgPicture.asset(
                          AppIcons.profileOutlined,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                              AppColors.greyBorderColor, BlendMode.srcIn),
                        ),
                        prefixFocused: SvgPicture.asset(
                          AppIcons.profileOutlined,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                              AppColors.black, BlendMode.srcIn),
                        ),
                      ),
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
                              EditProfileCubit.get(context)
                                  .checkUserDataChanges(context: context);
                            },
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          RadioWidget(
                            isValidationError:
                                cubit.genderValidation != null ? true : false,
                            isSelected:
                                cubit.isMale != null ? !cubit.isMale! : false,
                            icon: Icons.face_4,
                            text: AppStrings.female,
                            onTap: () {
                              cubit.changeGender(false);
                              EditProfileCubit.get(context)
                                  .checkUserDataChanges(context: context);
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
                      AddressWidget(
                        isValued: cubit.profileHasChanges,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      FormFieldWidget(
                        validator: (value) => AppValidator.generalValidator(
                            value: value ?? '', context: context),
                        keyInputType: TextInputType.none,
                        enableInteractive: false,
                        onChange: (value) {
                          cubit.checkUserDataChanges(context: context);
                        },
                        onTap: () async {
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) => Container(
                              height: 216,
                              padding: const EdgeInsets.only(top: 6.0),
                              // The Bottom margin is provided to align the popup above the system
                              // navigation bar.
                              margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              // Provide a background color for the popup.
                              color: CupertinoColors.systemBackground
                                  .resolveFrom(context),
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
                                    cubit.checkUserDataChanges(
                                        context: context);
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
                          colorFilter: ColorFilter.mode(
                              AppColors.black, BlendMode.srcIn),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CachedVariables.token == null
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
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
                                          text: AppStrings.iAgreeTo,
                                          context: context),
                                      style: GoogleFonts.inter(
                                        color: AppColors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  TextSpan(
                                      text: AppFunctions.translateText(
                                          text: AppStrings.privacyPolicy,
                                          context: context),
                                      style: GoogleFonts.inter(
                                          color: AppColors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          decoration:
                                              TextDecoration.underline)),
                                  TextSpan(
                                      text: ", ",
                                      style: GoogleFonts.inter(
                                        color: AppColors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  TextSpan(
                                      text: AppFunctions.translateText(
                                          text: AppStrings.termsAndConditions,
                                          context: context),
                                      style: GoogleFonts.inter(
                                          color: AppColors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          decoration:
                                              TextDecoration.underline)),
                                ])))
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              EditProfileBottomsWidget(),
            ],
          ),
        );
      },
    ));
  }
}
