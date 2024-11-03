import 'package:bookit/features/academy_profile/view_model/academy_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';
import '../about_widget/about_widget.dart';
import '../activitiy_list_widget/activit_list_widget.dart';
import '../gallery_widget/gallery_widget.dart';

class AcademyTabBarWidget extends StatefulWidget {
  final int id;

  const AcademyTabBarWidget({super.key, required this.id});

  @override
  State<AcademyTabBarWidget> createState() => _AcademyTabBarWidgetState();
}

class _AcademyTabBarWidgetState extends State<AcademyTabBarWidget>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcademyProfileCubit, AcademyProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AcademyProfileCubit.get(context);
        return Column(
          children: [
            TabBar(controller: controller, tabs: [
              Tab(
                icon: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      color: AppColors.black),
                  child: Center(
                    child: CustomTextWidget(
                        text: AppFunctions.translateText(
                            text: AppStrings.activities, context: context),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white),
                  ),
                ),
              ),
              Tab(
                icon: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      color: AppColors.black),
                  child: Center(
                    child: CustomTextWidget(
                        text: AppFunctions.translateText(
                            text: AppStrings.gallery, context: context),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white),
                  ),
                ),
              ),
              Tab(
                icon: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      color: AppColors.black),
                  child: Center(
                    child: CustomTextWidget(
                        text: AppFunctions.translateText(
                            text: AppStrings.about, context: context),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white),
                  ),
                ),
              ),
            ]),
            Expanded(
              child: TabBarView(controller: controller, children: [
                ActivityListWidget(id: widget.id),
                GalleryWidget(
                  galleries:
                      cubit.academyDetails?.data?.academy?.galleries ?? [],
                ),
                AboutWidget(
                  facebookUrl:
                      cubit.academyDetails?.data?.academy?.facebook ?? '',
                  instagramUrl:
                      cubit.academyDetails?.data?.academy?.instagram ?? '',
                  linkedInmUrl:
                      cubit.academyDetails?.data?.academy?.linkedin ?? '',
                  websiteUrl:
                      cubit.academyDetails?.data?.academy?.website ?? '',
                )
              ]),
            ),
          ],
        );
      },
    );
  }
}
