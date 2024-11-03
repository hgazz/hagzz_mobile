part of 'following_notifications_cubit.dart';

@immutable
abstract class FollowingNotificationsState {}

class FollowingNotificationsInitial extends FollowingNotificationsState {}

class SetFollowingValueSuccessState extends FollowingNotificationsState {}

class ChangeFollowingLoadingState extends FollowingNotificationsState {}

class ChangeFollowingSuccessState extends FollowingNotificationsState {
  final String message;

  ChangeFollowingSuccessState({required this.message});
}

class ChangeFollowingErrorState extends FollowingNotificationsState {
  final String error;

  ChangeFollowingErrorState({required this.error});
}

class ChangeFollowingStateSuccessState extends FollowingNotificationsState {
  final bool isFollowing;

  ChangeFollowingStateSuccessState({required this.isFollowing});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeFollowingStateSuccessState &&
          runtimeType == other.runtimeType &&
          isFollowing == other.isFollowing;

  @override
  int get hashCode => isFollowing.hashCode;
}
