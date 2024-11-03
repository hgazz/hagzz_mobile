import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/save_icon_widget/view/save_icon_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/regular_with12_font_size_text/regular_with12_font_size_text.dart';
import 'package:bookit/features/profile/view/widgets/bottom_sheet_widget.dart';
import 'package:bookit/features/session/view/widgets/leave_bottom_sheet_widget/leave_bottom_sheet_widget.dart';
import 'package:bookit/features/session/view/widgets/outlined_button_widget.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionsBottomSheetWidget extends StatelessWidget {
  final bool isJoined;
  final int id;
  final bool isSaved;

  const ActionsBottomSheetWidget(
      {super.key,
      required this.isJoined,
      required this.id,
      required this.isSaved});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: SessionCubit.get(context)..getTrainingDetailsById(id: id),
      child: BlocConsumer<SessionCubit, SessionState>(
        listener: (context, state) {
          var cubit = SessionCubit.get(context);

          if (state is ChangeFavValueSuccessState) {
            cubit.getTrainingDetailsById(id: id);
          }
        },
        builder: (context, state) {
          var cubit = SessionCubit.get(context);
          AppFunctions.logPrint(
              message:
                  "my Favvv ${cubit.trainingDetailsResponseModel?.data?.training?.isFav}");

          return cubit.isFav != null
              ? Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 72.w,
                            height: 72.h,
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.black),
                                borderRadius: BorderRadius.circular(16.r)),
                            child: SaveIconWidget(
                              id: id,
                              isSaved: cubit.trainingDetailsResponseModel?.data
                                      ?.training?.isFav ??
                                  false,
                              isBottomSheet: true,
                              isSessionDetails: true,
                              getSaveValue: (value) {
                                AppFunctions.logPrint(message: "Valuee $value");
                                cubit.changeFavValue(value: value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          const RegularWith12FontSizeText(
                              text: AppStrings.save, color: AppColors.black)
                        ],
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Column(
                        children: [
                          OutlinedButtonWidget(
                            onTap: () {
                              AppFunctions.shareApp(context: context);
                            },
                            icon: AppIcons.share,
                            width: 72,
                            height: 72,
                            iconWidth: 18.5,
                            fit: BoxFit.none,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          const RegularWith12FontSizeText(
                            text: AppStrings.share,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                      if (cubit.trainingDetailsResponseModel?.data?.isJoined ??
                          false) ...[
                        SizedBox(
                          width: 16.w,
                        ),
                        Column(
                          children: [
                            OutlinedButtonWidget(
                              onTap: () {
                                AppFunctions.popNavigate(context: context);
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => BottomSheetWidget(
                                        title: AppStrings.reason,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.55,
                                        child: LeaveBottomSheetWidget(
                                          trainingId: id,
                                        )));
                              },
                              icon: AppIcons.leave,
                              width: 72,
                              height: 72,
                              fit: BoxFit.none,
                              borderColor: AppColors.orangeRedColor,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            const RegularWith12FontSizeText(
                              text: AppStrings.leave,
                              color: AppColors.orangeRedColor,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                )
              : SizedBox.shrink();
        },
      ),
    );
  }
}
