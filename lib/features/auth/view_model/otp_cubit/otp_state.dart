part of 'otp_cubit.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

class VerifyOtpLoadingState extends OtpState {}

class ClearAddressDataSuccessState extends OtpState {}

class CachedUserDataSuccessState extends OtpState {}

class VerifyOtpSuccessState extends OtpState {
  final DefaultResponseModel model;
  final CachedDataModel cachedData;
  final String lang;

  VerifyOtpSuccessState(
      {required this.model, required this.cachedData, required this.lang});
}

class VerifyOtpErrorState extends OtpState {
  final String error;

  VerifyOtpErrorState({required this.error});
}

class ChangeTimerState extends OtpState {}

class ResendOtpLoadingState extends OtpState {}

class ResendOtpSuccessState extends OtpState {
  final String message;

  ResendOtpSuccessState({required this.message});
}

class ResendOtpErrorState extends OtpState {
  final String error;

  ResendOtpErrorState({required this.error});
}

class SendOtpViaWhatsAppLoadingState extends OtpState {}

class SendOtpViaWhatsAppSuccessState extends OtpState {
  final String message;

  SendOtpViaWhatsAppSuccessState({required this.message});
}

class SendOtpViaWhatsAppErrorState extends OtpState {
  final String error;

  SendOtpViaWhatsAppErrorState({required this.error});
}
