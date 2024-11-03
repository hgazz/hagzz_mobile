import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/util/constants/app_strings/app_strings.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextWidget(
          text: AppStrings.dontHaveAnAccount,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.onSurface,
        ),
        SizedBox(
          width: 3,
        ),
        InkWell(
          onTap: () {
            AppFunctions.namedNavigateTo(
              context: context,
              navigatedScreen: RouteConstants.createAnAccount,
            );
          },
          child: CustomTextWidget(
            text: AppStrings.register,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
