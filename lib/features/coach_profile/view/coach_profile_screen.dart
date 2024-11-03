import 'package:bookit/core/util/models/local_models/details_data_model/details_data_model.dart';
import 'package:bookit/features/coach_profile/model/enum_datails_catgory/enum_details_category.dart';
import 'package:bookit/features/coach_profile/view/widgets/coach_data_widget/coach_data_widget.dart';
import 'package:bookit/features/coach_profile/view/widgets/list_of_items_widget/list_of_items_widget.dart';
import 'package:bookit/features/coach_profile/view/widgets/selected_coach_details_category_widget/selected_coach_details_category_widget.dart';
import 'package:bookit/features/coach_profile/view_model/coach_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/constants/app_bottom_sheets/app_bottom_sheets.dart';
import '../../../core/util/constants/app_functions/app_functions.dart';
import '../../../core/util/constants/app_icons/app_icons.dart';
import '../../profile/view/widgets/header_widget.dart';

class CoachProfileScreen extends StatefulWidget {
  final DetailsDataModel data;

  const CoachProfileScreen({super.key, required this.data});

  @override
  State<CoachProfileScreen> createState() => _CoachProfileScreenState();
}

class _CoachProfileScreenState extends State<CoachProfileScreen> {
  @override
  void initState() {
    // var cubit = CoachProfileCubit.get(context);
    // cubit.upcomingTraining = [];
    // cubit.pastTraining = [];
    // cubit.page = 1;
    // cubit.totalPages = 0;
    // cubit.coachDetailsCategory = CoachDetailsCategory.upcoming;
    // cubit.getCoachDetails(id: widget.data.id);
    // cubit.getCoachTraining(id: widget.data.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CoachProfileCubit()
          ..getCoachDetails(id: widget.data.id)
          ..getCoachTraining(id: widget.data.id),
        child: SafeArea(
          child: Column(
            children: [
              BlocConsumer<CoachProfileCubit, CoachProfileState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return HeaderWidget(
                    backOnPressed: () {
                      var cubit = CoachProfileCubit.get(context);
                      cubit.upcomingTraining = [];
                      cubit.pastTraining = [];
                      cubit.page = 1;
                      cubit.totalPages = 0;
                      cubit.coachDetailsCategory =
                          CoachDetailsCategory.upcoming;
                      AppFunctions.popNavigate(context: context);
                    },
                    title: widget.data.name,
                    trailingIcon: AppIcons.menu,
                    trailingOnPressed: () {
                      AppBottomSheet.moreProfileIconBottomSheet(
                          context: context);
                    },
                  );
                },
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  child: Column(
                    children: [
                      const CoachDataWidget(),
                      SizedBox(
                        height: 10.h,
                      ),
                      const SelectedCoachDetailsCategoryWidget(),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: ListOfItemsWidget(
                          id: widget.data.id,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
