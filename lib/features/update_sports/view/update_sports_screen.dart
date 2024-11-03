import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/features/auth/view_model/choose_sports_cubit/choose_sports_cubit.dart';
import 'package:bookit/features/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:bookit/features/profile/view/widgets/header_widget.dart';
import 'package:bookit/features/update_sports/view/widgets/my_activity_widget/my_activity_widget.dart';
import 'package:bookit/features/update_sports/view/widgets/save_changes_and_discard_bottom/save_changes_and_discard_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateSportsScreen extends StatefulWidget {
  const UpdateSportsScreen({super.key});

  @override
  State<UpdateSportsScreen> createState() => _UpdateSportsScreenState();
}

class _UpdateSportsScreenState extends State<UpdateSportsScreen> {
  @override
  void initState() {
    EditProfileCubit.get(context).getUserData();
    // EditProfileCubit.get(context).getUserSports();
    EditProfileCubit.get(context).userSportIndex = -1;

    ChooseSportsCubit.get(context).getUserSports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(
                backOnPressed: () {
                  // EditProfileCubit.get(context).userSportIndex = -1;
                  AppFunctions.popNavigate(context: context);
                },
                title: AppStrings.editInterests),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: MyActivityWidget(),
              ),
            ),
            SaveChangesAndDiscardBottom(),
          ],
        ),
      ),
    );
  }
}
