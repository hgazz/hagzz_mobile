part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class ChangeGenderSuccessState extends RegisterState {}

final class SetGenderValidationErrorSuccessState extends RegisterState {}

final class ChangeAgreeTermsAndConditionSuccessState extends RegisterState {}

final class ChangeSelectedTypeSuccessState extends RegisterState {}

final class ValidationErrorState extends RegisterState {
  final RegisterValidationErrorModel model;

  ValidationErrorState({required this.model});
}

final class RegisterLoadingState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {
  final String message;

  RegisterSuccessState({required this.message});
}

final class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState({required this.error});
}

final class ChangeCountryCodeSuccessState extends RegisterState {}

final class ClearRegisterAllDataSuccessState extends RegisterState {}

final class AssignDataIfTapToChangeSuccessState extends RegisterState {}

final class SetAgreementValidationError extends RegisterState {}

final class ClearAddressDataSuccessState extends RegisterState {}
