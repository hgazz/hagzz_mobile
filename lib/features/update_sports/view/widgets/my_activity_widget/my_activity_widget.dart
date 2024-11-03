import 'package:bookit/core/util/widgets/loading_widget/loading_widget.dart';
import 'package:bookit/features/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/util/constants/app_alert/app_alert.dart';
import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';
import '../../../../auth/model/local_model/level_model.dart';
import '../../../../auth/view/choose_sports_screen/widgets/level_item_widget/level_item.dart';

class MyActivityWidget extends StatelessWidget {
  const MyActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        var cubit = EditProfileCubit.get(context);

        // if (state is UpdateUserProfileDataSuccessState) {
        //   cubit.getUserData(context: context);
        //   Ch.getUserSports();
        // }
        if (state is GetUserProfileDataErrorState) {
          if (state.error.contains("[connection error]")) {
            AppAlert.error(
                message: AppFunctions.translateText(
                    text: AppStrings.lostConnectionMessage, context: context),
                context: context,
                hasDuration: false);
          } else {
            AppAlert.error(message: state.error, context: context);
          }
        }
      },
      builder: (context, state) {
        var cubit = EditProfileCubit.get(context);
        return cubit.userModel != null
            ? ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = cubit.userModel?.data?.sports?[index];
                  return Center(
                    child: InkWell(
                      onTap: () {
                        cubit.changeUserSport(index);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.r),
                          border: Border.all(color: AppColors.greyBorderColor),
                        ),
                        child: cubit.userSportIndex != index
                            ? ListTile(
                                leading: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: CircleAvatar(
                                    radius: 12.r,
                                    backgroundColor: AppColors.transparent,
                                    child: SvgPicture.network(
                                      data?.icon ?? "",
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextWidget(
                                        text: data?.name ?? '',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    cubit.userSports.isNotEmpty
                                        ? cubit.userSports[index].levelName !=
                                                ""
                                            ? LevelItem(
                                                onTap: null,
                                                isChoose: true,
                                                data: LevelModel(
                                                    name: cubit
                                                            .userSports[index]
                                                            .levelName ??
                                                        '',
                                                    image: AppFunctions
                                                        .getLevelImage(cubit
                                                            .userSports[index]
                                                            .levelName)))
                                            : const SizedBox.shrink()
                                        : const SizedBox.shrink()
                                  ],
                                ),
                                trailing: cubit.userSports.isNotEmpty
                                    ? cubit.userSports[index].levelName != ""
                                        ? InkWell(
                                            onTap: () {
                                              cubit.checkUserDataChanges(
                                                  context: context);
                                              cubit.removeUserChosenLevel(
                                                  sportId: cubit
                                                      .userSports[index]
                                                      .sportId);
                                            },
                                            child: Icon(Icons.close))
                                        : null
                                    : null,
                              )
                            : Column(
                                children: [
                                  const Center(
                                    child: CustomTextWidget(
                                        text: AppStrings.yourLevel,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        cubit.levels.length,
                                        (index) => LevelItem(
                                            isChoose: false,
                                            onTap: () {
                                              cubit.changeUserLevel(index);
                                            },
                                            data: cubit.levels[index])),
                                  )
                                ],
                              ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    ),
                itemCount: cubit.userModel?.data?.sports?.length ?? 0)
            : LoadingWidget();
      },
    );
  }
}
