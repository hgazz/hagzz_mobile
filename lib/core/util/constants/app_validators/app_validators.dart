import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';

class AppValidator {
  static String? generalValidator({required String value, required context}) {
    if (value.trim().isEmpty) {
      return AppFunctions.translateText(
          text: AppStrings.fieldMustNotBeEmpty, context: context);
    }
    return null;
  }

  static String? phoneValidator({
    required String? value,
    required context,
    int minLength = 6,
    int maxLength = 15,
  }) {
    AppFunctions.logPrint(
        message:
            "Validation ${generalValidator(value: value ?? '', context: context)}");

    AppFunctions.logPrint(message: "Length : ${value?.replaceAll(" ", '')}");

    if (generalValidator(value: value ?? '', context: context) != null) {
      return generalValidator(value: value ?? '', context: context);
    } else {
      final digits = value?.replaceAll(RegExp(r'\D'), '') ?? '';
      final localPrefixOffset = digits.startsWith('0') ? 1 : 0;
      final allowedMinLength = minLength + localPrefixOffset;
      final allowedMaxLength = maxLength + localPrefixOffset;
      if (digits.length < allowedMinLength ||
          digits.length > allowedMaxLength) {
        return AppFunctions.translateText(
            text: AppStrings.phoneMustBeAtLeast6Number, context: context);
      } else {
        return null;
      }
    }
  }
}
