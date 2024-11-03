import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/constants/app_validators/app_validators.dart';
import 'package:bookit/core/util/widgets/border_bottom_widget/border_bottom_widget.dart';
import 'package:bookit/core/util/widgets/bottom_widget/bottom_widget.dart';
import 'package:bookit/core/util/widgets/form_field_Widget/form_field_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/session/view/widgets/leave_bottom_sheet_widget/leave_item_widget/leave_item_widget.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/router/rout_constants.dart';

class LeaveBottomSheetWidget extends StatefulWidget {
  final int trainingId;

  const LeaveBottomSheetWidget({super.key, required this.trainingId});

  @override
  State<LeaveBottomSheetWidget> createState() => _LeaveBottomSheetWidgetState();
}

class _LeaveBottomSheetWidgetState extends State<LeaveBottomSheetWidget> {
  List<String> texts = [
    AppStrings.foundABetterTrainingProgram,
    AppStrings.changedMyMind,
    AppStrings.timeConflict,
    AppStrings.other
  ];
  var reasonController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  int? selectedIndex;

  void onLeaveItemChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SessionCubit()..getTrainingDetailsById(id: widget.trainingId),
      child: BlocConsumer<SessionCubit, SessionState>(
        listener: (context, state) {
          if (state is CancelBookingSuccessState) {
            AppAlert.success(
                message: AppFunctions.translateText(
                    text: AppStrings.joinCancelSuccessfully, context: context),
                context: context);
            AppFunctions.namedNavigateAndFinishTo(
                context: context, navigatedScreen: RouteConstants.bottomNavBar);
          }
          if (state is CancelBookingErrorState) {
            AppFunctions.showError(error: state.error, context: context);
          }
        },
        builder: (context, state) {
          var cubit = SessionCubit.get(context);
          return Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                CustomTextWidget(
                    text: AppStrings.pleaseSpecifyTheReasonForLeaving,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGreyColor),
                SizedBox(height: 8.h),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => LeaveItemWidget(
                        isSelected: index == selectedIndex,
                        onChanged: (value) {
                          onLeaveItemChange(index);
                        },
                        text: texts[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 8.h,
                        ),
                    itemCount: 4),
                if (selectedIndex == 3)
                  Form(
                    key: formKey,
                    child: FormFieldWidget(
                        controller: reasonController,
                        hintText: "",
                        keyInputType: TextInputType.text,
                        validator: (value) {
                          return AppValidator.generalValidator(
                              value: value ?? '', context: context);
                        }),
                  ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: BorderBottomWidget(
                          text: AppStrings.cancel,
                          onTap: () {
                            AppFunctions.popNavigate(context: context);
                          }),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: BottomWidget(
                        backgroundColor: AppColors.redColor,
                        textColor: AppColors.white,
                        text: AppStrings.leave,
                        onTap: () {
                          if (selectedIndex != null) {
                            if (texts[selectedIndex ?? 0] != AppStrings.other) {
                              cubit.cancelJoin(
                                  reason: AppFunctions.translateText(
                                      text: texts[selectedIndex ?? 0],
                                      context: context));
                            } else {
                              if (formKey.currentState?.validate() ?? false) {
                                cubit.cancelJoin(reason: reasonController.text);
                              }
                            }
                          } else {
                            AppAlert.error(
                                message: AppFunctions.translateText(
                                    text: AppStrings.youMustChooseReasonFirst,
                                    context: context),
                                context: context);
                          }
                        },
                        isLoading:
                            state is CancelBookingLoadingState ? true : false,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
