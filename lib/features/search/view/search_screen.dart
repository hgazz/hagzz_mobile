import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';
import 'package:bookit/features/search/view/widgets/filter_chip_widget.dart';
import 'package:bookit/features/search/view/widgets/filter_widget.dart';
import 'package:bookit/features/search/view/widgets/search_list_widget.dart';
import 'package:bookit/features/search/view/widgets/sports_filter_widget.dart';
import 'package:bookit/features/search/view/widgets/white_rounded_text_form_field.dart';
import 'package:bookit/features/search/view_model/search_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/helper/cach/cached_variables.dart';
import '../../../core/util/constants/app_alert/app_alert.dart';
import '../../../core/util/constants/app_functions/app_functions.dart';
import '../../auth/view_model/choose_sports_cubit/choose_sports_cubit.dart';
import '../../profile/view/widgets/bottom_sheet_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    SearchCubit.get(context).getSearchData();
    SearchCubit.get(context).getAreas();
    ChooseSportsCubit.get(context).getSports();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is GetDefaultSearchDataErrorState) {
            if (state.error.contains("[connection error]")) {
              AppAlert.error(
                  message: AppFunctions.translateText(
                      text: AppStrings.lostConnectionMessage, context: context),
                  context: context,
                  hasDuration: false);
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  child: TitleTextWidget(text: AppStrings.exploreActivities),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: WhiteRoundedTextFormField(
                          controller: SearchCubit.get(context).searchController,
                          onChanged: (p0) {
                            if (p0.isEmpty) {
                              SearchCubit.get(context).getSearchData();
                              return;
                            } else if (p0.length > 2) {
                              SearchCubit.get(context).getSearchData();
                            }
                          },
                          validator: (p0) {},
                          keyboardType: TextInputType.text,
                          hintText: AppStrings.searchHintText.tr(),
                          borderSide: const BorderSide(
                            color: AppColors.greyBorderColor,
                          ),
                          prefixIcon: SvgPicture.asset(AppIcons.searchSvg),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: BlocConsumer<SearchCubit, SearchState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            var cubit = SearchCubit.get(context);
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => BottomSheetWidget(
                                      title: AppStrings.activities,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.65,
                                      child: SportsFilterWidget()),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.r),
                                margin: EdgeInsets.only(bottom: 5.h),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.borderColor,
                                        width: 1)),
                                child: cubit.selectedSportsFilters.isEmpty
                                    ? SvgPicture.asset(
                                        AppIcons.activities,
                                        width: 40.w,
                                        height: 30.h,
                                        fit: BoxFit.scaleDown,
                                      )
                                    : SvgPicture.network(
                                        cubit
                                            .selectedSportsFilters[cubit
                                                    .selectedSportsFilters
                                                    .length -
                                                1]
                                            .image,
                                        width: 40.w,
                                        height: 30.h,
                                        fit: BoxFit.scaleDown,
                                      ),
                              ),
                            );
                            return IconButton.outlined(
                              constraints: BoxConstraints(
                                minHeight: 60.h,
                                minWidth: 60.w,
                                maxHeight: 60.h,
                                maxWidth: 60.w,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => const BottomSheetWidget(
                                      title: AppStrings.activities,
                                      child: SportsFilterWidget()),
                                );
                              },
                              icon: cubit.selectedSportsFilters.isEmpty
                                  ? SvgPicture.asset(AppIcons.activities)
                                  : SvgPicture.network(
                                      cubit
                                          .selectedSportsFilters[cubit
                                                  .selectedSportsFilters
                                                  .length -
                                              1]
                                          .image,
                                      fit: BoxFit.fill,
                                    ),
                              style: IconButton.styleFrom(
                                side: const BorderSide(
                                  color: AppColors.greyBorderColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      var cubit = SearchCubit.get(context);
                      var quickFilters = CachedVariables.token != null
                          ? cubit.quickFilters
                          : cubit.quickFiltersWithoutAuth;
                      return Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: quickFilters.length,
                                itemBuilder: (context, index) {
                                  var current = quickFilters[index];
                                  bool isSelected = cubit.selectedQuickFilters
                                      .contains(index);
                                  return Padding(
                                    padding: EdgeInsets.only(right: 4.w),
                                    child: FilterChipWidget(
                                      text: current,
                                      isSelected: isSelected,
                                      onTap: () {
                                        cubit.changeSelectedQuickFilters(index);
                                        cubit.getSearchData();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => BottomSheetWidget(
                                      title: AppStrings.filters,
                                      child: FilterWidget()),
                                );
                              },
                              icon: SvgPicture.asset(AppIcons.filter)),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: SearchListWidget(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
