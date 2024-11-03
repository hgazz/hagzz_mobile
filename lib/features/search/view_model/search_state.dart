part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class ChangeSelectedQuickFilterSuccessState extends SearchState {}

class ChangeSelectedAreasFiltersSuccessState extends SearchState {}

class ChangeSelectedLevelFiltersSuccessState extends SearchState {}

class ChangeSelectedAgeGroupFiltersSuccessState extends SearchState {}

class ChangeSelectedGenderFilterSuccessState extends SearchState {}

class ChangeSelectedDaysFiltersSuccessState extends SearchState {}

class ChangeSelectedSportsFiltersSuccessState extends SearchState {}

class GetDefaultSearchDataLoadingState extends SearchState {}

class GetDefaultSearchDataSuccessState extends SearchState {}

class GetDefaultSearchDataErrorState extends SearchState {
  final String error;

  GetDefaultSearchDataErrorState({required this.error});
}

class GetAreasLoadingState extends SearchState {}

class GetAreasSuccessState extends SearchState {}

class GetAreasErrorState extends SearchState {}
