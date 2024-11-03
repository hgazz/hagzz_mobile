import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/search/view/widgets/filter_chip_widget.dart';
import 'package:bookit/features/search/view_model/search_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  var cubit = SearchCubit.get(context);
                  var filter = CachedVariables.token != null
                      ? cubit.quickFilters
                      : cubit.quickFiltersWithoutAuth;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextWidget(
                          text: AppStrings.quickFilters,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black),
                      SizedBox(
                        height: 8.h,
                      ),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: filter.map((e) {
                          bool isSelected = cubit.selectedQuickFilters
                              .contains(filter.indexOf(e));
                          AppFunctions.logPrint(message: "EEEEEE: $e");
                          return IntrinsicWidth(
                            child: FilterChipWidget(
                              text: e,
                              isSelected: isSelected,
                              onTap: () {
                                AppFunctions.logPrint(message: "Dataa: $e");
                                cubit.changeSelectedQuickFiltersByValue(e);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      _displayFilters(
                        AppStrings.startsWithin,
                        cubit.daysFilters,
                        cubit.selectedDaysFilters,
                            (index) {
                          showDateRangePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(
                                DateTime
                                    .now()
                                    .year,
                                DateTime
                                    .now()
                                    .month + 6,
                              )).then((value) {
                            if (value != null) {
                              cubit.startDate =
                                  DateFormat('yyyy-MM-dd').format(value.start);
                              cubit.endDate =
                                  DateFormat('yyyy-MM-dd').format(value.end);
                              cubit.daysFilters[0] =
                              '${cubit.startDate} -> ${cubit.endDate}';
                            } else {
                              cubit.startDate = '';
                              cubit.endDate = '';
                              cubit.daysFilters[0] = 'Select Date Range';
                            }
                            cubit.changeSelectedDaysFilters(index);
                          });
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: _displayFilters(
                            AppStrings.areas,
                            cubit.areasFilters
                                .map((e) => e.name ?? '')
                                .toList(),
                            cubit.selectedAreasFilters, (index) {
                          cubit.changeSelectedAreasFilters(index);
                        }),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      _displayFilters(AppStrings.level, cubit.levelFilters,
                          cubit.selectedLevelFilters, (index) {
                            cubit.changeSelectedLevelFilters(index);
                          }),
                      SizedBox(
                        height: 16.h,
                      ),
                      _displayFilters(
                        AppStrings.ageGroup,
                        cubit.ageGroupFilters,
                        cubit.selectedAgeGroupFilters,
                            (index) {
                          cubit.changeSelectedAgeGroupFilters(index);
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      _displayFilters(
                        AppStrings.gender,
                        cubit.genderFilters,
                        [cubit.selectedGenderFilterIndex],
                            (index) {
                          cubit.changeSelectedGenderFilter(index);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 16.0),
            child: FilledButton(
                onPressed: () {
                  SearchCubit.get(context).getSearchData();
                  AppFunctions.popNavigate(context: context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: CustomTextWidget(
                    text: AppStrings.applyFilter,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AppColors.black,
                  ),
                )),
          )
        ],
      ),
    );
  }
}

Widget _displayFilters(String filterTitle, List<String> filters,
    List<int> selectedFilters, void Function(int) onTap) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomTextWidget(
          text: filterTitle,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black),
      SizedBox(
        height: 8.h,
      ),
      Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: filters.map((e) {
          bool isSelected = selectedFilters.contains(filters.indexOf(e));
          int index = filters.indexOf(e);
          return IntrinsicWidth(
            child: FilterChipWidget(
              text: e,
              isSelected: isSelected,
              onTap: () => onTap(index),
            ),
          );
        }).toList(),
      ),
    ],
  );
}
