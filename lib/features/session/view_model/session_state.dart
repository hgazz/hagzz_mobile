part of 'session_cubit.dart';

@immutable
abstract class SessionState {}

class SessionInitial extends SessionState {}

class OpenPaymentSuccessState extends SessionState {}

class ChangeSessionDetailsCategorySuccessState extends SessionState {
  final SessionDetailsCategories category;

  ChangeSessionDetailsCategorySuccessState({required this.category});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeSessionDetailsCategorySuccessState &&
          runtimeType == other.runtimeType &&
          category == other.category;

  @override
  int get hashCode => category.hashCode;
}

class ChangeSelectedClassIndexSuccessState extends SessionState {
  final int index;

  ChangeSelectedClassIndexSuccessState({required this.index});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeSelectedClassIndexSuccessState &&
          runtimeType == other.runtimeType &&
          index == other.index;

  @override
  int get hashCode => index.hashCode;
}

class GetTrainingDetailsByIdLoadingState extends SessionState {}

class GetTrainingDetailsByIdSuccessState extends SessionState {}

class GetTrainingDetailsByIdErrorState extends SessionState {
  final String error;

  GetTrainingDetailsByIdErrorState(this.error);
}

class JoinTrainingSessionLoadingState extends SessionState {}

class JoinTrainingSessionSuccessState extends SessionState {}

class JoinTrainingSessionErrorState extends SessionState {
  final String error;

  JoinTrainingSessionErrorState(this.error);
}

class ChangeFavValueSuccessState extends SessionState {}

class InitialPaymentSdkSuccessState extends SessionState {}

class BuildPaymentSdkLoadingState extends SessionState {}

class BuildPaymentSdkSuccessState extends SessionState {
  final String orderId;
  final String invoiceId;

  BuildPaymentSdkSuccessState({required this.orderId, required this.invoiceId});
}

class BuildPaymentSdkErrorState extends SessionState {
  final String error;

  BuildPaymentSdkErrorState({required this.error});
}

class ChangeDraggableStateSuccessState extends SessionState {}

class CancelBookingLoadingState extends SessionState {}

class CancelBookingSuccessState extends SessionState {}

class CancelBookingErrorState extends SessionState {
  final ErrorResponseModel error;

  CancelBookingErrorState({required this.error});
}

class GetPaymentDataLoadingState extends SessionState {}

class GetPaymentDataSuccessState extends SessionState {}

class GetPaymentDataErrorState extends SessionState {
  final ErrorResponseModel error;

  GetPaymentDataErrorState({required this.error});
}
