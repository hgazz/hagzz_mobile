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
    required bool isEgypt,
  }) {
    AppFunctions.logPrint(
        message:
            "Validation ${generalValidator(value: value ?? '', context: context)}");

    AppFunctions.logPrint(message: "Length : ${value?.replaceAll(" ", '')}");

    if (generalValidator(value: value ?? '', context: context) != null) {
      return generalValidator(value: value ?? '', context: context);
    } else {
      if ((value?.replaceAll(" ", "").length ?? 0) < 6) {
        return AppFunctions.translateText(
            text: AppStrings.phoneMustBeAtLeast6Number, context: context);
      } else {
        return null;
      }
    }
  }
}
