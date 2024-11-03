import 'package:bookit/core/util/widgets/loading_widget/loading_widget.dart';
import 'package:bookit/features/academy_profile/view_model/academy_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/widgets/training_card_widget/training_card_widget.dart';

class ActivityListWidget extends StatefulWidget {
  final int id;

  const ActivityListWidget({
    super.key,
    required this.id,
  });

  @override
  State<ActivityListWidget> createState() => _ActivityListWidgetState();
}

class _ActivityListWidgetState extends State<ActivityListWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    var cubit = AcademyProfileCubit.get(context);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (cubit.totalPages >= cubit.page) {
          cubit.getTraining(id: widget.id);
        }
      }
    });
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
        return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < cubit.academyTraining.length) {
              return TrainingCardWidget(
                  isVertical: true,
                  isPast: false,
                  trainingItem: cubit.academyTraining[index]);
            } else {
              return cubit.totalPages == cubit.page
                  ? LoadingWidget()
                  : SizedBox.shrink();
            }
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 4.h,
          ),
          itemCount: cubit.academyTraining.length + 1,
        );
      },
    );
  }
}
