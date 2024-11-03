part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeSliderIndexSuccessState extends HomeState {
  final int index;

  ChangeSliderIndexSuccessState({required this.index});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeSliderIndexSuccessState &&
          runtimeType == other.runtimeType &&
          index == other.index;

  @override
  int get hashCode => index.hashCode;
}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final HomeModel homeData;

  HomeSuccessState({required this.homeData});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeSuccessState &&
          runtimeType == other.runtimeType &&
          homeData == other.homeData;

  @override
  int get hashCode => homeData.hashCode;
}

class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState({required this.error});
}

class GetAllTrainingLoadingState extends HomeState {}

class GetAllTrainingSuccessState extends HomeState {}

class GetAllTrainingErrorState extends HomeState {
  final String error;

  GetAllTrainingErrorState({required this.error});
}

class GetAllAcademiesLoadingState extends HomeState {}

class GetAllAcademiesSuccessState extends HomeState {}

class GetAllAcademiesErrorState extends HomeState {
  final String error;

  GetAllAcademiesErrorState({required this.error});
}
