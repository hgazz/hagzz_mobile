import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/widgets/address_widget/view_model/address_cubit.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/util/constants/app_strings/app_strings.dart';

class AlreadyHaveAnAccountWidget extends StatelessWidget {
  const AlreadyHaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextWidget(
          text: AppStrings.alreadyHaveAccount,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.onSurface,
        ),
        SizedBox(
          width: 3,
        ),
        InkWell(
          onTap: () {
            AddressCubit.get(context).selectedArea = null;
            AddressCubit.get(context).selectedCountry = null;
            AddressCubit.get(context).selectedCity = null;
            AppFunctions.namedNavigateTo(
              context: context,
              navigatedScreen: RouteConstants.enterPhone,
            );
          },
          child: CustomTextWidget(
            text: AppStrings.signIn,
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
