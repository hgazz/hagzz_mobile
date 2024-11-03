import 'package:bookit/features/session/view_model/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../../../core/util/widgets/text_widgets/custom_text_widget.dart';
import '../../../arrow_container_widget/arrow_container_widget.dart';

class IndexesWidget extends StatelessWidget {
  const IndexesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionCubit, SessionState>(
        builder: (context, state) {
          var cubit = SessionCubit.get(context);
          AppFunctions.logPrint(
              message:
                  "indeeeex :${cubit.selectedClassIndex} \n lengtthhh ${cubit.trainingDetailsResponseModel?.data?.training?.classes?.length}");
          return Padding(
            padding: EdgeInsets.only(top: 16.0.h),
            child: SizedBox(
              height: 42,
              child: Row(
                children: [
                  ArrowContainerWidget(
                      onTap: cubit.selectedClassIndex == 1
                          ? null
                          : () {
                              cubit.changeSelectedClassIndex(
                                i: cubit.selectedClassIndex - 1,
                              );
                            },
                      backgroundColor: cubit.selectedClassIndex == 1
                          ? AppColors.classesIndexDisabled
                          : AppColors.surfaceContainer,
                      isLeft: true),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: ListView.separated(
                      controller: cubit.classIndicatorScrollController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        var i = index + 1;
                        return IconButton.filled(
                          onPressed: () {
                            cubit.changeSelectedClassIndex(i: i);
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: cubit.selectedClassIndex == i
                                ? AppColors.dotsColor
                                : AppColors.surfaceContainer,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 42,
                            minHeight: 42,
                          ),
                          icon: CustomTextWidget.server(
                              text: i.toString(),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black),
                        );
                      },
                      itemCount: cubit.trainingDetailsResponseModel?.data
                              ?.training?.classes?.length ??
                          0,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  ArrowContainerWidget(
                      onTap: cubit.selectedClassIndex ==
                              (cubit.trainingDetailsResponseModel?.data
                                      ?.training?.classes?.length ??
                                  0)
                          ? null
                          : () {
                              cubit.changeSelectedClassIndex(
                                i: cubit.selectedClassIndex + 1,
                              );
                            },
                      backgroundColor: cubit.selectedClassIndex !=
                              (cubit.trainingDetailsResponseModel?.data
                                      ?.training?.classes?.length ??
                                  0)
                          ? AppColors.surfaceContainer
                          : AppColors.classesIndexDisabled,
                      isLeft: false),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
