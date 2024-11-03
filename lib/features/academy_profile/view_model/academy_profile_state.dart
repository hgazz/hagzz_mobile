part of 'academy_profile_cubit.dart';

@immutable
abstract class AcademyProfileState {}

class AcademyProfileInitial extends AcademyProfileState {}

class ChangeCoachDetailsCategorySuccessState extends AcademyProfileState {
  final AcademyDetailsCategories category;

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

class GetAcademyDetailsLoadingState extends AcademyProfileState {}

class GetAcademyDetailsSuccessState extends AcademyProfileState {}

class GetAcademyDetailsErrorState extends AcademyProfileState {
  final String error;

  GetAcademyDetailsErrorState({required this.error});
}

class GetAcademyTrainingLoadingState extends AcademyProfileState {}

class GetAcademyTrainingSuccessState extends AcademyProfileState {}

class GetAcademyTrainingErrorState extends AcademyProfileState {
  final String error;

  GetAcademyTrainingErrorState({required this.error});
}
