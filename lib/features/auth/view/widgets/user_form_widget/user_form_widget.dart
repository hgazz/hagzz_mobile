import 'package:bookit/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view_model/auth_cubit/auth_state.dart';

class UserFormWidget extends StatelessWidget {
  const UserFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // var cubit = AuthCubit.get(context);
        //
        // if (state is GetUerImageFromGallery) {
        //   if (cubit.image != null) {
        //     cubit.changeProfileChangesState(hasChanges: true);
        //   }
        // }
        // if (state is ChangeGenderSuccessState) {
        //   cubit.checkUserDataChanges(context: context);
        // }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Container();
        /*  return Form(
          key: cubit.registerFormKey,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              UserImageWidget(
                onTap: () async {
                  cubit.getImageFromGallery();
                },
                file: cubit.image,
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
                  colorFilter:
                      ColorFilter.mode(AppColors.black, BlendMode.srcIn),
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
              AddressWidget(),
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
                            cubit.checkUserDataChanges(context: context);
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
                        const Expanded(
                            child:
                                TextWithFontSize14AndWeight500WithDynamicColorWidget(
                          text: AppStrings.termsAndConditions,
                          color: AppColors.black,
                          maxLines: 2,
                        ))
                      ],
                    )
                  : SizedBox.shrink(),
            ],
          ),
        );*/
      },
    );
  }
}
