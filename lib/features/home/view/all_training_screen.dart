import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/training_card_widget/training_card_widget.dart';
import 'package:bookit/features/home/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/constants/app_functions/app_functions.dart';
import '../../../core/util/widgets/loading_widget/loading_widget.dart';
import '../../profile/view/widgets/header_widget.dart';

class AllTrainingScreen extends StatefulWidget {
  const AllTrainingScreen({super.key});

  @override
  State<AllTrainingScreen> createState() => _AllTrainingScreenState();
}

class _AllTrainingScreenState extends State<AllTrainingScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    var cubit = HomeCubit.get(context);
    cubit.getAllTraining(context: context);
    scrollController.addListener(() {
      AppFunctions.logPrint(message: "Listen");
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        AppFunctions.logPrint(message: "Listen");
        if (cubit.totalPages >= cubit.page) {
          AppFunctions.logPrint(message: "Listen");
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
                    HomeCubit.get(context).allTraining = [];
                    HomeCubit.get(context).page = 1;
                    HomeCubit.get(context).totalPages = 0;
                  },
                  title: AppStrings.allTraining,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      AnimatedConditionalBuilder(
                          condition: cubit.allTraining != null,
                          builder: (context) => ListView.separated(
                                shrinkWrap: true,
                                controller: scrollController,
                                itemBuilder: (context, index) {
                                  if (index <
                                      (cubit.allTraining?.length ?? 0)) {
                                    return TrainingCardWidget(
                                        isVertical: true,
                                        isPast: true,
                                        trainingItem:
                                            cubit.allTraining?[index]);
                                  } else {
                                    return cubit.totalPages == cubit.page
                                        ? LoadingWidget()
                                        : SizedBox.shrink();
                                  }
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                                itemCount: (cubit.allTraining?.length ?? 0) + 1,
                              ),
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
