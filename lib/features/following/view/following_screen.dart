import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/features/following/model/category_enum.dart';
import 'package:bookit/features/following/view/widgets/list_widget/list_widget.dart';
import 'package:bookit/features/following/view/widgets/selected_category_widget/selected_category_widget.dart';
import 'package:bookit/features/following/view_model/following_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/constants/app_functions/app_functions.dart';
import '../../profile/view/widgets/header_widget.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  void initState() {
    FollowingCubit.get(context).page = 1;
    FollowingCubit.get(context).selectedCategory = FollowingCategory.places;

    FollowingCubit.get(context).getFollowData();
    FollowingCubit.get(context).getCoachesForU();
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
                FollowingCubit.get(context).page = 1;
                FollowingCubit.get(context).selectedCategory =
                    FollowingCategory.places;
                AppFunctions.popNavigate(context: context);
              },
              title: AppStrings.following,
              trailingIcon: null,
            ),
            Expanded(
              child: Column(
                children: [
                  const SelectedCategoryWidget(),
                  SizedBox(
                    height: 16.h,
                  ),
                  const ListWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
