import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/loading_widget/loading_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/regular_with12_font_size_text/regular_with12_font_size_text.dart';
import 'package:bookit/features/search/model/local_model/sports_choose_model/sports_choose_model.dart';
import 'package:bookit/features/search/view_model/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../auth/view_model/choose_sports_cubit/choose_sports_cubit.dart';

class SportsFilterWidget extends StatelessWidget {
  const SportsFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        var cubit = SearchCubit.get(context);

        var selectedSports = cubit.selectedSportsFilters;
        return Expanded(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              BlocConsumer<ChooseSportsCubit, ChooseSportsState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  var authCubit = ChooseSportsCubit.get(context);
                  var sports =
                      ChooseSportsCubit.get(context).sportsModel?.data ?? [];
                  return AnimatedConditionalBuilder(
                      condition: authCubit.sportsModel != null,
                      builder: (context) => GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            childAspectRatio: 0.98,
                            crossAxisSpacing: 4.w,
                            children: List.generate(sports.length, (index) {
                              bool isSelected = selectedSports.contains(
                                  SportsChooseModel(
                                      id: sports[index].id ?? -1,
                                      image: sports[index].icon ?? ''));
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        cubit.changeSelectedSportsFilters(
                                            SportsChooseModel(
                                                id: sports[index].id ?? -1,
                                                image:
                                                    sports[index].icon ?? ''));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(16.r),
                                        margin: EdgeInsets.only(bottom: 5.h),
                                        decoration: BoxDecoration(
                                            color: isSelected
                                                ? AppColors.black
                                                : AppColors.transparent,
                                            shape: BoxShape.circle,
                                            boxShadow: isSelected
                                                ? [
                                                    BoxShadow(
                                                        color: Color(0xff000000)
                                                            .withOpacity(0.03),
                                                        blurRadius: 14.r,
                                                        offset: Offset(0, 0))
                                                  ]
                                                : [],
                                            gradient: isSelected
                                                ? null
                                                : LinearGradient(
                                                    begin: AlignmentDirectional
                                                        .topCenter,
                                                    end: AlignmentDirectional
                                                        .bottomCenter,
                                                    colors: [
                                                        Color(0xffC9C9C9),
                                                        AppColors.white,
                                                      ]),
                                            border: Border.all(
                                                color: AppColors.borderColor,
                                                width: 1)),
                                        child: SvgPicture.network(
                                          sports[index].icon ?? '',
                                          fit: BoxFit.scaleDown,
                                          color: isSelected
                                              ? AppColors.white
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  RegularWith12FontSizeText.server(
                                      text: sports[index].name ?? '',
                                      color: AppColors.black),
                                ],
                              );
                            }),
                          ),
                      fallback: (context) => const LoadingWidget());
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                    onPressed: () {
                      SearchCubit.get(context).getSearchData();
                      AppFunctions.popNavigate(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: CustomTextWidget(
                        text: AppStrings.applyFilter,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
