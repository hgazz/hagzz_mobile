part of 'help_support_cubit.dart';

@immutable
sealed class HelpSupportState {}

final class HelpSupportInitial extends HelpSupportState {}

final class GetHelpSupportLoadingState extends HelpSupportState {}

final class GetHelpSupportSuccessState extends HelpSupportState {}

final class GetHelpSupportErrorState extends HelpSupportState {
  final ErrorResponseModel error;

  GetHelpSupportErrorState({required this.error});
}
