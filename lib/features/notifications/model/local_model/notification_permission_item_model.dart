import 'package:bookit/core/util/constants/app_strings/app_strings.dart';

class NotificationPermissionItemModel {
  final String iconText;
  final String description;

  NotificationPermissionItemModel({
    required this.iconText,
    required this.description,
  });

  static List<NotificationPermissionItemModel>
      notificationPermissionItemModelList = [
    NotificationPermissionItemModel(
      iconText: '💡',
      description: AppStrings.notificationsPermissionPhrase1,
    ),
    NotificationPermissionItemModel(
      iconText: '🚀',
      description: AppStrings.notificationsPermissionPhrase2,
    ),
    NotificationPermissionItemModel(
      iconText: '📅',
      description: AppStrings.notificationsPermissionPhrase3,
    ),
  ];
}
