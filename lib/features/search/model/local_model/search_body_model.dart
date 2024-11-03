class SearchBodyModel {
  final String searchText;
  final List<int> selectedQuickFilters;
  final List<int> selectedAreasFilters;
  final List<int> selectedLevelFilters;
  final List<int> selectedAgeGroupFilters;
  final int selectedGenderFilterIndex;
  final String startDate;
  final String endDate;
  final List<int> selectedSportsFilters;

  SearchBodyModel({
    required this.searchText,
    required this.selectedQuickFilters,
    required this.selectedAreasFilters,
    required this.selectedLevelFilters,
    required this.selectedAgeGroupFilters,
    required this.selectedGenderFilterIndex,
    required this.startDate,
    required this.endDate,
    required this.selectedSportsFilters,
  });

  Map<String, dynamic> toJson() {
    return {
      if (selectedSportsFilters.isNotEmpty) 'sports_ids': selectedSportsFilters,
      if (searchText.isNotEmpty) 'search': searchText,
      if (selectedQuickFilters.contains(0)) 'near_me': true,
      if (selectedQuickFilters.contains(1)) 'start_soon': true,
      if (selectedQuickFilters.contains(2)) 'almost_full': true,
      if (selectedAreasFilters.isNotEmpty) 'areas_ids': selectedAreasFilters,
      if (selectedAgeGroupFilters.isNotEmpty &&
          !selectedAgeGroupFilters.contains(0))
        'age_group': selectedAgeGroupFilters
            .map((e) => e == 1
                ? 'Kids'
                : e == 2
                    ? 'Juniors'
                    : 'Adults')
            .toList(),
      if (selectedLevelFilters.isNotEmpty && !selectedLevelFilters.contains(0))
        'level': selectedLevelFilters
            .map((e) => e == 1
                ? 'Beginner'
                : e == 2
                    ? 'Intermediate'
                    : 'Advanced')
            .toList(),
      if (selectedGenderFilterIndex != 0)
        'gender': selectedGenderFilterIndex == 1 ? 'Men' : 'Women',
      if (startDate.isNotEmpty && endDate.isNotEmpty) 'start_date': startDate,
      if (startDate.isNotEmpty && endDate.isNotEmpty) 'end_date': endDate,
    };
  }
}
