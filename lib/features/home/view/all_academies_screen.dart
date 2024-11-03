import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/core/util/constants/app_lottie/app_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/util/constants/app_functions/app_functions.dart';
import '../../../core/util/constants/app_strings/app_strings.dart';
import '../../../core/util/models/local_models/place_coach_model/place_coach_model.dart';
import '../../../core/util/widgets/loading_widget/loading_widget.dart';
import '../../../core/util/widgets/places_widget/places_widget.dart';
import '../../profile/view/widgets/header_widget.dart';
import '../view_model/home_cubit.dart';

class AllAcademiesScreen extends StatefulWidget {
  const AllAcademiesScreen({super.key});

  @override
  State<AllAcademiesScreen> createState() => _AllAcademiesScreenState();
}

class _AllAcademiesScreenState extends State<AllAcademiesScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    var cubit = HomeCubit.get(context);
    cubit.getAllAcademies(context: context);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (cubit.totalPages >= cubit.page) {
          cubit.getAllTraining(context: context);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return SafeArea(
            child: Column(
              children: [
                HeaderWidget(
                  backOnPressed: () {
                    AppFunctions.popNavigate(context: context);
                    HomeCubit.get(context).allAcademies = [];
                    HomeCubit.get(context).page = 1;
                    HomeCubit.get(context).totalPages = 0;
                  },
                  title: AppStrings.allAcademies,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      AnimatedConditionalBuilder(
                          condition: cubit.allAcademies != null,
                          builder: (context) => AnimatedConditionalBuilder(
                              condition:
                                  cubit.allAcademies?.isNotEmpty ?? false,
                              builder: (context) => ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 16.h),
                                    physics: BouncingScrollPhysics(),
                                    controller: scrollController,
                                    itemBuilder: (context, index) {
                                      if (index <
                                          (cubit.allAcademies?.length ?? 0)) {
                                        return PlacesWidget(
                                          isVertical: true,
                                          data: PlaceCoachModel(
                                              id: cubit.allAcademies?[index]
                                                      .id ??
                                                  0,
                                              image: cubit.allAcademies?[index]
                                                      .logo ??
                                                  '',
                                              name: cubit.allAcademies?[index]
                                                      .commercialName ??
                                                  '',
                                              department: AppFunctions.getStringFromList(
                                                  item: cubit
                                                          .allAcademies?[index]
                                                          .sports ??
                                                      []),
                                              following: cubit
                                                  .allAcademies?[index]
                                                  .followsCount
                                                  .toString(),
                                              rate: null),
                                        );
                                      } else {
                                        return cubit.totalPages == cubit.page
                                            ? LoadingWidget()
                                            : SizedBox.shrink();
                                      }
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 10.h,
                                    ),
                                    itemCount:
                                        (cubit.allAcademies?.length ?? 0) + 1,
                                  ),
                              fallback: (context) => Center(
                                  child: Lottie.asset(AppLottie.noData))),
                          fallback: (context) => const LoadingWidget()),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
