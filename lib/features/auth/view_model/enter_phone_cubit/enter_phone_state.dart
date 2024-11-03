part of 'enter_phone_cubit.dart';

@immutable
sealed class EnterPhoneState {}

final class EnterPhoneInitial extends EnterPhoneState {}

final class ChangeSelectedTypeSuccessState extends EnterPhoneState {}

final class LoginLoadingState extends EnterPhoneState {}

final class LoginSuccessState extends EnterPhoneState {}

final class UserNotFoundState extends EnterPhoneState {}

final class ClearLoginAllDataState extends EnterPhoneState {}

final class LoginErrorState extends EnterPhoneState {
  final String error;

  LoginErrorState({required this.error});
}

final class ChangeCountryCodeSuccessState extends EnterPhoneState {}

final class CachedPhoneNumberState extends EnterPhoneState {}

final class CheckCachedPhoneNumberState extends EnterPhoneState {}
