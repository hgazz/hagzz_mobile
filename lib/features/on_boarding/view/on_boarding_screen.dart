import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/bottom_widget/bottom_widget.dart';
import 'package:bookit/core/util/widgets/dot_indicator_widget/dot_indicator_widget.dart';
import 'package:bookit/core/util/widgets/text_bottom_widget/text_bottom_widget.dart';
import 'package:bookit/features/on_boarding/view/widgets/page_view_widget.dart';
import 'package:bookit/features/on_boarding/view_model/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/util/widgets/border_bottom_widget/border_bottom_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => OnBoardingCubit(),
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = OnBoardingCubit.get(context);
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  children: [
                    Container(
                      height: 52,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextBottomWidget(
                            text: AppStrings.continueAsGuest,
                            fontSize: 16,
                            onTap: () {
                              AppFunctions.namedNavigateAndFinishTo(
                                  context: context,
                                  navigatedScreen: RouteConstants.bottomNavBar);
                            },
                            textColor: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Expanded(
                      child: PageView(
                        controller: cubit.controller,
                        onPageChanged: (index) {
                          cubit.changeCurrentIndex(index);
                        },
                        children: List.generate(3, (index) {
                          return PageViewWidget(
                            object: cubit.onBoardingList[index],
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      width: 41.h,
                    ),
                    DotIndicatorWidget(
                      currentIndex: cubit.currentIndex,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: AppColors.lemonColor,
                        dotColor: AppColors.lightGreyColor,
                        dotWidth: 9,
                        dotHeight: 9,
                        spacing: 4,
                      ),
                    ),
                    SizedBox(
                      height: 48.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: BorderBottomWidget(
                          text: AppStrings.signIn,
                          height: 52,
                          onTap: () {
                            AppFunctions.namedNavigateTo(
                                context: context,
                                navigatedScreen: RouteConstants.enterPhone);
                          },
                        )),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                            child: BottomWidget(
                                text: AppStrings.register,
                                onTap: () {
                                  AppFunctions.namedNavigateTo(
                                      context: context,
                                      navigatedScreen:
                                          RouteConstants.createAnAccount);
                                },
                                isLoading: false)),
                      ],
                    )
                    // SizedBox(
                    //   height: 40.h,
                    // ),
                    // BottomWidget(
                    //     isLoading: false,
                    //     text:
                    //         cubit.onBoardingList[cubit.currentIndex].buttonText,
                    //     onTap: () {
                    //       var currentIndex = cubit.currentIndex;
                    //       // todo add condition
                    //       if (currentIndex == 2) {
                    //         CacheHelper.setData(
                    //                 key: CachedKeys.onBoard, value: "true")
                    //             .then((value) async {
                    //           CachedVariables.onBoard =
                    //               await CacheHelper.getData(
                    //                   key: CachedKeys.onBoard);
                    //         });
                    //         AppFunctions.namedNavigateTo(
                    //             context: context,
                    //             navigatedScreen: RouteConstants.enterPhone);
                    //       }
                    //       cubit.controller.nextPage(
                    //           duration: const Duration(milliseconds: 300),
                    //           curve: Curves.easeInOut);
                    //     })
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
