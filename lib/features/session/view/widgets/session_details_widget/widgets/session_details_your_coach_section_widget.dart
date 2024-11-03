import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/models/local_models/details_data_model/details_data_model.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/session/view/widgets/outlined_button_widget.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionDetailsYourCoachSectionWidget extends StatelessWidget {
  const SessionDetailsYourCoachSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        var cubit = SessionCubit.get(context);
        var trainingDetails =
            cubit.trainingDetailsResponseModel?.data?.training;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: AppStrings.yourCoach,
              color: AppColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: AppColors.surfaceContainer),
              padding: EdgeInsets.all(16.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundImage:
                              NetworkImage(trainingDetails?.coach?.image ?? ''),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Expanded(
                          child: CustomTextWidget.server(
                            text: trainingDetails?.coach?.name ?? '',
                            color: AppColors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButtonWidget(
                    onTap: () {
                      AppFunctions.namedNavigateTo(
                          context: context,
                          navigatedScreen: RouteConstants.coachProfile,
                          args: DetailsDataModel(
                              id: trainingDetails?.coach?.id ?? 0,
                              name: trainingDetails?.coach?.name ?? ''));
                    },
                    icon: AppIcons.profileOutlined,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
