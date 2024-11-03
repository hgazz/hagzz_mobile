import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/widgets/loading_widget/loading_widget.dart';
import 'package:bookit/core/util/widgets/my_error_widget/my_error_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/profile/view_model/faqs_cubit/faqs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/constants/app_strings/app_strings.dart';
import '../../../core/util/widgets/bottom_widget/bottom_widget.dart';
import '../model/faq_model.dart';
import 'widgets/header_widget.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => FaqsCubit()..getFaqs(),
        child: SafeArea(
            child: Column(
          children: [
            HeaderWidget(
              backOnPressed: () {
                Navigator.pop(context);
              },
              title: AppStrings.faqs,
            ),
            Expanded(
              child: BlocBuilder<FaqsCubit, FaqsState>(
                builder: (context, state) {
                  if (state is GetFaqsLoadingState) {
                    return LoadingWidget();
                  } else if (state is GetFaqsErrorState) {
                    return MyErrorWidget(
                      onPressed: () {
                        BlocProvider.of<FaqsCubit>(context).getFaqs();
                      },
                    );
                  } else if (state is GetFaqsSuccessState) {
                    final List<FaqModel> faqs = state.faqs;
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                          ExpansionPanelList(
                            elevation: 0,
                            animationDuration: const Duration(seconds: 1),
                            expansionCallback: (panelIndex, isExpanded) {
                              setState(() {
                                selectedIndex = selectedIndex == panelIndex
                                    ? -1
                                    : panelIndex;
                              });
                            },
                            materialGapSize: 16,
                            dividerColor: AppColors.transparent,
                            children: List.generate(faqs.length, (index) {
                              return ExpansionPanel(
                                backgroundColor: AppColors.transparent,
                                canTapOnHeader: true,
                                isExpanded: selectedIndex == index,
                                headerBuilder: (context, isExpanded) => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        CustomTextWidget.server(
                                          text: faqs[index].question,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.black,
                                          maxLine: 10,
                                          isServer: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                body: Padding(
                                  padding: EdgeInsets.only(
                                    left: 16.w,
                                    right: 16.w,
                                    bottom: 16.h,
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      children: [
                                        CustomTextWidget.server(
                                          text: faqs[index].answer,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          maxLine: 10,
                                          color: AppColors.black,
                                          isServer: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 24.h),
                          // BottomWidget(
                          //   text: AppStrings.faqsButtonText,
                          //   onTap: () {},
                          //   isLoading: false,
                          // )
                        ],
                      ),
                    );

                  }
                  return MyErrorWidget(
                    onPressed: () {
                      BlocProvider.of<FaqsCubit>(context).getFaqs();
                    },
                  );
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
