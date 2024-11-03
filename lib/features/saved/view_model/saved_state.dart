part of 'saved_cubit.dart';

@immutable
abstract class SavedState {}

class SavedInitial extends SavedState {}

class GetSavedDataLoadingState extends SavedState {}

class GetSavedDateSuccessState extends SavedState {}

class GetSavedDateErrorState extends SavedState {
  final String error;

  GetSavedDateErrorState({required this.error});
}

class SaveDataToHiveLoadingState extends SavedState {}

class SaveDataToHiveSuccessState extends SavedState {}

class SaveDataToHiveErrorState extends SavedState {
  final String error;

  SaveDataToHiveErrorState({required this.error});
}

class ChangeSavedValueSuccessState extends SavedState {}

class SetSavedValueSuccessState extends SavedState {}
