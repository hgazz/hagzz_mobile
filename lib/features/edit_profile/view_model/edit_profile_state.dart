part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class GetUerImageFromGallery extends EditProfileState {}

final class GetUserProfileDataLoadingState extends EditProfileState {}

final class GetUserProfileDataSuccessState extends EditProfileState {}

final class GetUserProfileDataErrorState extends EditProfileState {
  final String error;

  GetUserProfileDataErrorState({required this.error});
}

final class AssignDataToController extends EditProfileState {}

final class UpdateUserProfileDataLoadingState extends EditProfileState {}

final class UpdateUserProfileDataSuccessState extends EditProfileState {
  final String message;

  UpdateUserProfileDataSuccessState({required this.message});
}

final class UpdateUserProfileDataErrorState extends EditProfileState {
  final String error;

  UpdateUserProfileDataErrorState({required this.error});
}

final class ChangeProfileSaveChangeBottomState extends EditProfileState {
  final bool hasChanges;

  ChangeProfileSaveChangeBottomState({required this.hasChanges});
}

final class CheckUserDataChangesSuccessState extends EditProfileState {}

final class ChangeGenderSuccessState extends EditProfileState {}

final class SetGenderValidationErrorSuccessState extends EditProfileState {}

final class ChangeAgreeTermsAndConditionSuccessState extends EditProfileState {}

class GetSportsLoadingState extends EditProfileState {}

class GetSportsSuccessState extends EditProfileState {
  GetSportsSuccessState();
}

class GetSportsErrorState extends EditProfileState {
  final String error;

  GetSportsErrorState({required this.error});
}

class RemoveChosenLevelSuccessState extends EditProfileState {}

class ChangeSportsSuccessState extends EditProfileState {}

class ChangeLevelSuccessState extends EditProfileState {}
