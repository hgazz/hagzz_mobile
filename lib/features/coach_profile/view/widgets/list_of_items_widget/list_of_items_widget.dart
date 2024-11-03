import 'package:bookit/core/util/widgets/training_card_widget/training_card_widget.dart';
import 'package:bookit/features/coach_profile/view_model/coach_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/widgets/loading_widget/loading_widget.dart';
import '../../../model/enum_datails_catgory/enum_details_category.dart';

class ListOfItemsWidget extends StatefulWidget {
  final int id;

  const ListOfItemsWidget({super.key, required this.id});

  @override
  State<ListOfItemsWidget> createState() => _ListOfItemsWidgetState();
}

class _ListOfItemsWidgetState extends State<ListOfItemsWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    var cubit = CoachProfileCubit.get(context);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (cubit.totalPages >= cubit.page) {
          cubit.getCoachTraining(id: widget.id);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoachProfileCubit, CoachProfileState>(
      builder: (context, state) {
        var cubit = CoachProfileCubit.get(context);
        return PageView(
          controller: cubit.pageController,
          onPageChanged: (index) {
            if (index == 0) {
              cubit.changeCoachDetailsCategory(
                  category: CoachDetailsCategory.upcoming);
            }
            if (index == 1) {
              cubit.changeCoachDetailsCategory(
                  category: CoachDetailsCategory.past);
            }
          },
          children: [
            ListView.separated(
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index < cubit.upcomingTraining.length) {
                    return TrainingCardWidget(
                      isVertical: true,
                      isPast: false,
                      trainingItem: cubit.upcomingTraining[index],
                    );
                  } else {
                    return cubit.totalPages == cubit.page
                        ? LoadingWidget()
                        : SizedBox.shrink();
                  }
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 8.h,
                    ),
                itemCount: cubit.upcomingTraining.length),
            ListView.separated(
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index < cubit.pastTraining.length) {
                    return TrainingCardWidget(
                      isVertical: true,
                      isPast: false,
                      trainingItem: cubit.pastTraining[index],
                    );
                  } else {
                    return cubit.totalPages == cubit.page
                        ? LoadingWidget()
                        : SizedBox.shrink();
                  }
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 8.h,
                    ),
                itemCount: cubit.pastTraining.length)
          ],
        );
      },
    );
  }
}
