import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/session/view/widgets/session_classes_widget/widget/bring_with_u_widget/bring_with_u_widget.dart';
import 'package:bookit/features/session/view/widgets/session_classes_widget/widget/date_time_widget/date_time_widget.dart';
import 'package:bookit/features/session/view/widgets/session_classes_widget/widget/indexes_widget/indexes_widget.dart';
import 'package:bookit/features/session/view/widgets/session_classes_widget/widget/outcomes_widget/outcomes_widget.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionClassesWidget extends StatelessWidget {
  const SessionClassesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        var cubit = SessionCubit.get(context);
        var selectedIndex = cubit.selectedClassIndex;
        AppFunctions.logPrint(message: "Selected Index :::: ${selectedIndex}");
        var classCount = cubit.trainingDetailsResponseModel?.data?.training
                ?.classes?.length ??
            0;
        if (classCount == 0) {
          return Center(
            child: CustomTextWidget(
              text: AppStrings.noClassesAvailable,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          );
        }
        var currentClass = cubit.trainingDetailsResponseModel?.data?.training
            ?.classes?[selectedIndex - 1];
        AppFunctions.logPrint(
            message: "Current Classss :::: ${currentClass?.id}");
        AppFunctions.logPrint(message: "Timeee: ${currentClass?.startTime}");
        AppFunctions.logPrint(message: "Timeee: ${currentClass?.endTime}");
        return Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Center(
                      child: CustomTextWidget.server(
                        text: currentClass?.title ?? '',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    // date and time section
                    DateTimeWidget(
                        date: currentClass?.date ?? '',
                        time:
                            "${AppFunctions.convertTime(currentClass?.startTime ?? '')} ${currentClass?.endTime != null ? "-" : ""} ${AppFunctions.convertTime(currentClass?.endTime ?? '')}"),
                    SizedBox(
                      height: 16.h,
                    ),
                    // outcomes section
                    OutcomesWidget(outcomes: currentClass?.outComes ?? []),
                    SizedBox(
                      height: 16.h,
                    ),
                    // Bring with you section
                    BringWithUWidget(
                      bringWithU: currentClass?.bringWithMe ?? [],
                    ),
                  ],
                ),
              ),
              IndexesWidget()
            ],
          ),
        );
      },
    );
  }
}
