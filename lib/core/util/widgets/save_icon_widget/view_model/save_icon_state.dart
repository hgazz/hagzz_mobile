part of 'save_icon_cubit.dart';

@immutable
abstract class SaveIconState {}

class SaveIconInitial extends SaveIconState {}

class SavedTrainingLoadingState extends SaveIconState {}

class SavedTrainingSuccessState extends SaveIconState {
  final String message;

  SavedTrainingSuccessState({required this.message});
}

class SavedTrainingErrorState extends SaveIconState {
  final String error;

  SavedTrainingErrorState({required this.error});
}

class UnSavedTrainingLoadingState extends SaveIconState {}

class UnSavedTrainingSuccessState extends SaveIconState {
  final String message;

  UnSavedTrainingSuccessState({required this.message});
}

class UnSavedTrainingErrorState extends SaveIconState {
  final String error;

  UnSavedTrainingErrorState({required this.error});
}

class SetSaveValueSuccessState extends SaveIconState {}

class ChangeSaveValueSuccessState extends SaveIconState {}

class UnAuthorizedState extends SaveIconState {}
