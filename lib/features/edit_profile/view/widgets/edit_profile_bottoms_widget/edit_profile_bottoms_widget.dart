import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/border_bottom_widget/border_bottom_widget.dart';
import 'package:bookit/features/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/address_widget/view_model/address_cubit.dart';
import '../../../../../core/util/widgets/bottom_widget/bottom_widget.dart';
import '../../../../home/view_model/home_cubit.dart';
import '../../../model/local_model/edit_profile_local_model.dart';

class EditProfileBottomsWidget extends StatelessWidget {
  const EditProfileBottomsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        var cubit = EditProfileCubit.get(context);

        if (state is UpdateUserProfileDataSuccessState) {
          cubit.profileHasChanges = false;
          AppAlert.success(message: state.message, context: context);
          HomeCubit.get(context).getHomeData(context: context);
          cubit.getUserData(context: context);
          AppFunctions.popNavigate(context: context);
        }
      },
      builder: (context, state) {
        var cubit = EditProfileCubit.get(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              BottomWidget(
                  isDisabled: cubit.profileHasChanges == true ? null : true,
                  isLoading: state is! UpdateUserProfileDataLoadingState
                      ? false
                      : true,
                  height: 43,
                  text: AppStrings.saveChanges,
                  onTap: () {
                    if (cubit.formKey.currentState?.validate() ?? false) {
                      cubit.updateProfile(
                          data: EditProfileLocalModel(
                        image: cubit.image?.path ?? null,
                        phone: cubit.phoneNumberController.text,
                        name: cubit.nameController.text,
                        birthDate: cubit.dateController.text.isNotEmpty
                            ? cubit.dateController.text
                            : "2000-09-01",
                        gender: cubit.isMale ?? false ? 'male' : 'female',
                        countryId: (AddressCubit.get(context)
                                    .selectedCountry
                                    ?.id ??
                                (cubit.userModel?.data?.profile?.country?.id ??
                                    0))
                            .toString(),
                        cityId: (AddressCubit.get(context).selectedCity?.id ??
                                (cubit.userModel?.data?.profile?.city?.id ?? 0))
                            .toString(),
                        areaId: (AddressCubit.get(context).selectedArea?.id ??
                                (cubit.userModel?.data?.profile?.area?.id ?? 0))
                            .toString(),
                        countryCode:
                            cubit.userModel?.data?.profile?.countryCode ?? "+20",
                      ));
                    }
                    // List<String> sports = [];
                    // List<String> levels = [];
                    // if (cubit.isProfile == true) {
                    //   cubit.userModel?.data?.profile?.sports?.forEach((element) {
                    //     sports.add(element.id.toString());
                    //     levels.add(element.level ?? '');
                    //   });
                    //
                    //   if (cubit.registerFormKey.currentState?.validate() ??
                    //       false) {
                    //     cubit.updateProfile(
                    //         data: RegisterModel(
                    //             image: cubit.image,
                    //             phone: cubit.phoneNumberController.text,
                    //             name: cubit.nameController.text,
                    //             birthDate: cubit.dateController.text,
                    //             gender: cubit.isMale ?? false ? 'male' : 'female',
                    //             countryId: (AddressCubit.get(context)
                    //                         .selectedCountry
                    //                         ?.id ??
                    //                     (cubit.userModel?.data?.profile?.country
                    //                             ?.id ??
                    //                         0))
                    //                 .toString(),
                    //             cityId: (AddressCubit.get(context)
                    //                         .selectedCity
                    //                         ?.id ??
                    //                     (cubit.userModel?.data?.profile?.city?.id ??
                    //                         0))
                    //                 .toString(),
                    //             areaId:
                    //                 (AddressCubit.get(context).selectedArea?.id ??
                    //                         (cubit.userModel?.data?.profile?.area
                    //                                 ?.id ??
                    //                             0))
                    //                     .toString(),
                    //             sportId: sports,
                    //             level: levels));
                    //   }
                    // } else {
                    //   AppFunctions.logPrint(
                    //       message: "User Sports : ${cubit.userSports}");
                    //   AppFunctions.logPrint(
                    //       message: "choose sports : ${cubit.chooseSports}");
                    //   cubit.userSports.forEach((element) {
                    //     AppFunctions.logPrint(
                    //         message: "user sport ${element.sportId}");
                    //     if (element.levelName != "") {
                    //       sports.add(element.sportId.toString());
                    //       levels.add(element.levelName.toString());
                    //     }
                    //   });
                    //   cubit.chooseSports.forEach((element) {
                    //     AppFunctions.logPrint(
                    //         message: "choosen sport ${element.sportId}");
                    //
                    //     if (!sports.contains(element.sportId)) {
                    //       levels.add(element.levelName);
                    //       sports.add(element.sportId.toString());
                    //     }
                    //   });
                    //   cubit.updateProfile(
                    //       data: RegisterModel(
                    //           image: cubit.image,
                    //           phone: cubit.phoneNumberController.text,
                    //           name: cubit.nameController.text,
                    //           birthDate: cubit.dateController.text,
                    //           gender: cubit.isMale ?? false ? 'male' : 'female',
                    //           countryId: cubit
                    //                   .userModel?.data?.profile?.country?.id
                    //                   .toString() ??
                    //               '',
                    //           cityId: cubit.userModel?.data?.profile?.city?.id
                    //                   .toString() ??
                    //               '',
                    //           areaId: cubit.userModel?.data?.profile?.area?.id
                    //                   .toString() ??
                    //               '',
                    //           sportId: sports,
                    //           level: levels));
                    // }
                  }),
              SizedBox(
                height: 8.h,
              ),
              BorderBottomWidget(
                  text: AppStrings.discard,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
