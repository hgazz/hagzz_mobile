part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class ChangeNotificationTabSuccessState extends NotificationState {
  final NotificationTabs category;

  ChangeNotificationTabSuccessState({required this.category});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangeNotificationTabSuccessState &&
        other.category == category;
  }

  @override
  int get hashCode => category.hashCode;
}

class GetNotificationLoadingState extends NotificationState {}

class GetNotificationSuccessState extends NotificationState {}

class GetNotificationErrorState extends NotificationState {
  final String error;

  GetNotificationErrorState({required this.error});
}

class MakeNotificationReadLoadingState extends NotificationState {}

class MakeNotificationReadSuccessState extends NotificationState {}

class MakeNotificationReadErrorState extends NotificationState {
  final String error;

  MakeNotificationReadErrorState({required this.error});
}
