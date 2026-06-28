import 'package:bookit/core/util/constants/app_icons/app_icons.dart';

class AppMedia {
  static String sportAsset(String? name) {
    final normalized = (name ?? '').toLowerCase().trim();

    if (normalized.contains('football')) return AppIcons.football;
    if (normalized.contains('swim') || normalized.contains('aqua')) {
      return AppIcons.swimmingToRight;
    }
    if (normalized.contains('basket')) return AppIcons.basketball;
    if (normalized.contains('volley')) return AppIcons.volleyball;
    if (normalized.contains('tennis') || normalized.contains('padel')) {
      return AppIcons.tennis;
    }

    return AppIcons.placeholder;
  }
}
