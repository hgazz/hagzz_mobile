import 'package:flutter/cupertino.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SavePasswordSuccessState extends AuthState {}

class ChangeShownProfileSuccessState extends AuthState {}

class ChangeAgreeTermsAndConditionSuccessState extends AuthState {}

class ChangeGenderSuccessState extends AuthState {}

class ChangeLevelSuccessState extends AuthState {}

class ChangeSportsSuccessState extends AuthState {}

class RemoveChosenLevelSuccessState extends AuthState {}

class ChangeOnClickFieldSuccessState extends AuthState {
  final bool isClick;

  ChangeOnClickFieldSuccessState({required this.isClick});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeOnClickFieldSuccessState &&
          runtimeType == other.runtimeType &&
          isClick == other.isClick;

  @override
  int get hashCode => isClick.hashCode;
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class UserNotFoundState extends AuthState {}

class LoginErrorState extends AuthState {
  final String error;

  LoginErrorState({required this.error});
}

class GetUerImageFromGallery extends AuthState {}

class AssignDataToController extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final String message;

  RegisterSuccessState({required this.message});
}

class RegisterErrorState extends AuthState {
  final String error;

  RegisterErrorState({required this.error});
}

class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {
  final String message;

  LogoutSuccessState({required this.message});
}

class LogoutErrorState extends AuthState {
  final String error;

  LogoutErrorState({required this.error});
}

class ChangeSendCodeDurationSuccessState extends AuthState {}

class ClearAllData extends AuthState {}

class CachedDataSuccessState extends AuthState {}

class DeleteAccountLoadingState extends AuthState {}

class DeleteAccountSuccessState extends AuthState {
  final String message;

  DeleteAccountSuccessState({required this.message});
}

class DeleteAccountErrorState extends AuthState {
  final String error;

  DeleteAccountErrorState({required this.error});
}

class CheckUserDataChangesSuccessState extends AuthState {}

class SetGenderValidationErrorSuccessState extends AuthState {}

class ChangeProfileSaveChangeBottomState extends AuthState {
  final bool hasChanges;

  ChangeProfileSaveChangeBottomState({required this.hasChanges});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeProfileSaveChangeBottomState &&
          runtimeType == other.runtimeType &&
          hasChanges == other.hasChanges;

  @override
  int get hashCode => hasChanges.hashCode;
}
