import 'package:bookit/features/session/model/training_details_response_model.dart';
import 'package:bookit/features/session/view/widgets/session_details_widget/widgets/session_details_date_and_description_section_widget.dart';
import 'package:bookit/features/session/view/widgets/session_details_widget/widgets/session_details_joined_section_widget.dart';
import 'package:bookit/features/session/view/widgets/session_details_widget/widgets/session_details_organized_by_section_widget.dart';
import 'package:bookit/features/session/view/widgets/session_details_widget/widgets/session_details_your_coach_section_widget.dart';
import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionDetailsWidget extends StatelessWidget {
  const SessionDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView(
        children: [
          // first section of the session details (level, date, time, location)
          const SessionDetailsDateAndDescribtionSectionWidget(),
          SizedBox(
            height: 16.h,
          ),

          // second section of the session details (Joined)
          const SessionDetailsJoinedSectionWidget(),
          SizedBox(
            height: 16.h,
          ),

          // third section of the session details (Organized by)
          BlocConsumer<SessionCubit, SessionState>(
              builder: (context, state) {
                var cubit = SessionCubit.get(context);
                var training =
                    cubit.trainingDetailsResponseModel?.data?.training;
                return SessionDetailsOrganizedBySectionWidget(
                  training: training ?? Training(),
                );
              },
              listener: (context, state) {}),
          SizedBox(
            height: 16.h,
          ),

          // fourth section of the session details (Your Coach)
          const SessionDetailsYourCoachSectionWidget(),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }
}
