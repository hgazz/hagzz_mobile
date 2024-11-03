part of 'following_cubit.dart';

@immutable
abstract class FollowingState {}

class FollowingInitial extends FollowingState {}

class ChangeSelectedCategorySuccessState extends FollowingState {
  final FollowingCategory category;

  ChangeSelectedCategorySuccessState({required this.category});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeSelectedCategorySuccessState &&
          runtimeType == other.runtimeType &&
          category == other.category;

  @override
  int get hashCode => category.hashCode;
}

class GetFollowDataLoadingState extends FollowingState {}

class GetFollowDataSuccessState extends FollowingState {}

class GetFollowDataErrorState extends FollowingState {
  final String error;

  GetFollowDataErrorState({required this.error});
}

class GetCoachesForUDataLoadingState extends FollowingState {}

class GetCoachesForUDataSuccessState extends FollowingState {}

class GetCoachesForUDataErrorState extends FollowingState {
  final String error;

  GetCoachesForUDataErrorState({required this.error});
}
