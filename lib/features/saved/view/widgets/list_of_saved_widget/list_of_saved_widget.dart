import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/core/util/constants/app_images/app_images.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/models/local_models/empty_model_data/empty_model.dart';
import 'package:bookit/core/util/widgets/empty_widget/empty_widget.dart';
import 'package:bookit/core/util/widgets/loading_widget/loading_widget.dart';
import 'package:bookit/core/util/widgets/training_card_widget/training_card_widget.dart';
import 'package:bookit/features/saved/view_model/saved_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOfSavedWidget extends StatefulWidget {
  const ListOfSavedWidget({super.key});

  @override
  State<ListOfSavedWidget> createState() => _ListOfSavedWidgetState();
}

class _ListOfSavedWidgetState extends State<ListOfSavedWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    var cubit = SavedCubit.get(context);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (cubit.totalPages >= cubit.page) {
          cubit.getSavedData();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavedCubit, SavedState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SavedCubit.get(context);
        return AnimatedConditionalBuilder(
            condition: cubit.savedData != null,
            builder: (context) => AnimatedConditionalBuilder(
                condition: !(cubit.savedData?.isEmpty ?? true),
                builder: (context) => Align(
                      alignment: Alignment.topCenter,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        primary: false,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          if (index < (cubit.savedData?.length ?? 0)) {
                            return TrainingCardWidget(
                                isVertical: true,
                                isPast: false,
                                trainingItem: cubit.savedData?[index]);
                          } else {
                            return cubit.totalPages == cubit.page
                                ? LoadingWidget()
                                : SizedBox.shrink();
                          }
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8.h),
                        itemCount: (cubit.savedData?.length ?? 0) + 1,
                      ),
                    ),
                fallback: (context) => EmptyWidget(
                    data: EmptyModel(
                        image: AppImages.emptySaved,
                        title: AppStrings.emptySavedMessage,
                        description: AppStrings.emptySavedLabelMessage))),
            fallback: (context) => ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  itemBuilder: (context, index) => TrainingCardWidget(
                      isVertical: true, isPast: false, trainingItem: null),
                  separatorBuilder: (context, index) => SizedBox(height: 8.h),
                  itemCount: 5,
                ));
      },
    );
  }
}
