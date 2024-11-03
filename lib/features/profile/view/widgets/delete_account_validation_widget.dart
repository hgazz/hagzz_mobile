import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum DeleteAccountAndSignOutValidationType { deleteAccount, signOut }

class DeleteAccountAndSignOutValidationWidget extends StatelessWidget {
  final DeleteAccountAndSignOutValidationType type;

  const DeleteAccountAndSignOutValidationWidget(
      {super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextWidget(
          text: type == DeleteAccountAndSignOutValidationType.deleteAccount
              ? AppStrings.deleteAccountWarningMessage
              : AppStrings.signOutWarningMessage,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.greyColor,
          maxLine: 3,
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 32.h,
        ),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CustomTextWidget(
                    text: AppStrings.cancel,
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.redColor,
                ),
                onPressed: () async {
                  if (type ==
                      DeleteAccountAndSignOutValidationType.deleteAccount) {
                    await AuthCubit.get(context).deleteAccount().then((value) =>
                        AppFunctions.namedNavigateAndFinishTo(
                            context: context,
                            navigatedScreen: RouteConstants.enterPhone));
                  } else {
                    await AuthCubit.get(context).logout().then((value) =>
                        AppFunctions.namedNavigateAndFinishTo(
                            context: context,
                            navigatedScreen: RouteConstants.enterPhone));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CustomTextWidget(
                    text: type ==
                            DeleteAccountAndSignOutValidationType.deleteAccount
                        ? AppStrings.yesDelete
                        : AppStrings.yesSignOut,
                    color: AppColors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
