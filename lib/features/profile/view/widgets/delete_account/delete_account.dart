import 'package:bookit/features/profile/view/widgets/bottom_sheet_widget.dart';
import 'package:bookit/features/profile/view/widgets/delete_account_validation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/helper/cach/cach_helper.dart';
import '../../../../../core/helper/cach/cached_keys.dart';
import '../../../../../core/helper/cach/cached_variables.dart';
import '../../../../../core/helper/router/rout_constants.dart';
import '../../../../../core/util/constants/app_alert/app_alert.dart';
import '../../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../../core/util/constants/app_icons/app_icons.dart';
import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../auth/view_model/auth_cubit/auth_cubit.dart';
import '../../../../auth/view_model/auth_cubit/auth_state.dart';
import '../../../../bottom_nav_bar/view_model/bottom_nav_bar_cubit.dart';
import '../profile_menu_item_widget.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccessState) {
          CachedVariables.token = null;
          CachedVariables.userId = null;
          CacheHelper.deleteData(key: CachedKeys.token);
          CacheHelper.deleteData(key: CachedKeys.userId);
          AppAlert.success(message: state.message, context: context);
          AppFunctions.namedNavigateAndFinishTo(
              context: context, navigatedScreen: RouteConstants.enterPhone);
          BottomNavBarCubit.get(context).changeIndex(0);
        }
        if (state is DeleteAccountErrorState) {
          AppAlert.error(message: state.error, context: context);
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return ProfileMenuItemWidget(
          title: AppStrings.deleteAccount,
          icon: AppIcons.deleteAccount,
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => BottomSheetWidget(
                title: AppStrings.deleteAccount,
                height: MediaQuery.of(context).size.height * 0.30,
                child: DeleteAccountAndSignOutValidationWidget(
                    type: DeleteAccountAndSignOutValidationType.deleteAccount),
              ),
            );
          },
          onTap: () {
            AppAlert.error(
                message: AppFunctions.translateText(
                    text: AppStrings.pressAndHoldToDeleteAccount,
                    context: context),
                toastLength: Toast.LENGTH_SHORT,
                context: context);
            // cubit.deleteAccount();
          },
        );
      },
    );
  }
}
