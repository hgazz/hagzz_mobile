part of 'coach_profile_cubit.dart';

@immutable
abstract class CoachProfileState {}

class CoachProfileInitial extends CoachProfileState {}

class ChangeCoachDetailsCategorySuccessState extends CoachProfileState {
  final CoachDetailsCategory category;

  ChangeCoachDetailsCategorySuccessState({required this.category});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeCoachDetailsCategorySuccessState &&
          runtimeType == other.runtimeType &&
          category == other.category;

  @override
  int get hashCode => category.hashCode;
}

class GetCoachProfileDataLoadingState extends CoachProfileState {}

class GetCoachProfileDataSuccessState extends CoachProfileState {}

class GetCoachProfileDataErrorState extends CoachProfileState {
  final String error;

  GetCoachProfileDataErrorState({required this.error});
}

class GetCoachTrainingLoadingState extends CoachProfileState {}

class GetCoachTrainingSuccessState extends CoachProfileState {}

class GetCoachTrainingErrorState extends CoachProfileState {
  final String error;

  GetCoachTrainingErrorState({required this.error});
}
