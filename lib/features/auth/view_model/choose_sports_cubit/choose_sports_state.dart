part of 'choose_sports_cubit.dart';

@immutable
sealed class ChooseSportsState {}

final class ChooseSportsInitial extends ChooseSportsState {}

final class GetSportsLoadingState extends ChooseSportsState {}

final class GetSportsSuccessState extends ChooseSportsState {
  GetSportsSuccessState();
}

final class GetSportsErrorState extends ChooseSportsState {
  final String error;

  GetSportsErrorState({required this.error});
}

final class ChangeSportsSuccessState extends ChooseSportsState {}

final class ChangeLevelSuccessState extends ChooseSportsState {}

final class RemoveChosenLevelSuccessState extends ChooseSportsState {}

final class UpdateSportsLoadingState extends ChooseSportsState {}

final class UpdateSportsSuccessState extends ChooseSportsState {}

final class UpdateSportsErrorState extends ChooseSportsState {
  final String error;

  UpdateSportsErrorState({required this.error});
}

final class UpdateSportsValidationErrorState extends ChooseSportsState {
  final UpdateSportsValidationError error;

  UpdateSportsValidationErrorState({required this.error});
}
