part of 'my_sessions_cubit.dart';

@immutable
abstract class MySessionsState {}

class MySessionsInitial extends MySessionsState {}

class ChangeMySessionsCategorySuccessState extends MySessionsState {
  final MySessionsCategories category;

  ChangeMySessionsCategorySuccessState({required this.category});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangeMySessionsCategorySuccessState &&
        other.category == category;
  }

  @override
  int get hashCode => category.hashCode;
}

class GetMySessionsLoadingState extends MySessionsState {}

class GetMySessionsSuccessState extends MySessionsState {}

class GetSavedDateErrorState extends MySessionsState {
  final String error;

  GetSavedDateErrorState({required this.error});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetSavedDateErrorState && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}
