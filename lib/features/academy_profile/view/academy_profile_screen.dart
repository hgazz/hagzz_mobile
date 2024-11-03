import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/models/local_models/details_data_model/details_data_model.dart';
import 'package:bookit/features/academy_profile/model/local_models/statistics_model.dart';
import 'package:bookit/features/academy_profile/view/widgets/academy_data_widget/academy_data_widget.dart';
import 'package:bookit/features/academy_profile/view/widgets/determine_section_widget/determine_section_widget.dart';
import 'package:bookit/features/academy_profile/view/widgets/selected_academy_details_data_widget/selected_academy_details_data_widget.dart';
import 'package:bookit/features/academy_profile/view_model/academy_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/constants/app_bottom_sheets/app_bottom_sheets.dart';
import '../../following/view_model/following_cubit.dart';
import '../../profile/view/widgets/header_widget.dart';
import '../model/enum_model/enum_details_model.dart';

class AcademyProfileScreen extends StatelessWidget {
  final DetailsDataModel academyData;

  const AcademyProfileScreen({super.key, required this.academyData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => AcademyProfileCubit()
        ..getTraining(id: academyData.id)
        ..getAcademyDetails(id: academyData.id),
      child: BlocBuilder<AcademyProfileCubit, AcademyProfileState>(
        builder: (context, state) {
          var cubit = AcademyProfileCubit.get(context);
          return SafeArea(
            child: Column(
              children: [
                HeaderWidget(
                  backOnPressed: () {
                    AcademyProfileCubit.get(context).academyTraining = [];
                    AcademyProfileCubit.get(context).page = 1;
                    AcademyProfileCubit.get(context).totalPages = 0;
                    AcademyProfileCubit.get(context).academyDetailsCategories =
                        AcademyDetailsCategories.activities;

                    AppFunctions.popNavigate(context: context);
                  },
                  title: academyData.name,
                  trailingIcon: AppIcons.menu,
                  trailingOnPressed: () {
                    AppBottomSheet.moreProfileIconBottomSheet(context: context);
                  },
                ),
                BlocConsumer<AcademyProfileCubit, AcademyProfileState>(
                  listener: (context, state) {
                    if (state is GetAcademyDetailsSuccessState) {
                      FollowingCubit.get(context).page = 1;
                    }
                  },
                  builder: (context, state) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 2.h),
                        child: Column(
                          children: [
                            AnimatedConditionalBuilder(
                                condition: cubit.academyDetails != null,
                                builder: (context) {
                                  AppFunctions.logPrint(
                                      message:
                                          "Logggggooo: ${cubit.academyDetails?.data?.academy?.logo}");
                                  return AcademyDataWidget(
                                    data: StatisticsModel(
                                        image: cubit.academyDetails?.data
                                                ?.academy?.logo ??
                                            '',
                                        id: cubit.academyDetails?.data?.academy?.id ??
                                            0,
                                        isFollow: cubit.academyDetails?.data
                                                ?.isFollowing ??
                                            false,
                                        numberOfCoaches: cubit.academyDetails
                                                ?.data?.academy?.coachesCount ??
                                            0,
                                        numberOfTrainers: cubit
                                                .academyDetails
                                                ?.data
                                                ?.academy
                                                ?.trainingsCount ??
                                            0,
                                        numberOfLocations: cubit
                                                .academyDetails
                                                ?.data
                                                ?.academy
                                                ?.addressesCount ??
                                            0,
                                        name: cubit.academyDetails?.data
                                                ?.academy?.commercialName ??
                                            '',
                                        followers: cubit.academyDetails?.data?.academy?.followsCount ?? 0,
                                        specialization: AppFunctions.getStringFromList(item: cubit.academyDetails?.data?.academy?.sports ?? []) ?? ''),
                                  );
                                },
                                fallback: (context) => const AcademyDataWidget(
                                      data: null,
                                    )),
                            // SizedBox(height: 12.h),
                            //   id: widget.academyData.id,
                            // ),
                            SizedBox(height: 12.h),
                            const SelectedAcademyDetailsDataWidget(),
                            SizedBox(height: 12.h),
                            DetermineSectionWidget(id: academyData.id)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    ));
  }
}
