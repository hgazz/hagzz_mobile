import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_alert/app_alert.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/features/auth/view/widgets/stepper_widget/stepper_widget.dart';
import 'package:bookit/features/auth/view/widgets/titles_widgtes/determine_title_widget.dart';
import 'package:bookit/features/auth/view/widgets/user_form_widget/user_form_widget.dart';
import 'package:bookit/features/auth/view/widgets/user_prefered_widget/user_prefered_widget.dart';
import 'package:bookit/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../profile/view/widgets/header_widget.dart';
import '../view_model/auth_cubit/auth_state.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  void initState() {
    if (CachedVariables.token != null) {
      // AuthCubit.get(context).getUserSports();
      // AuthCubit.get(context).getUserData();
    } else {
      // AuthCubit.get(context).getSports();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        var cubit = AuthCubit.get(context);
        if (state is RegisterSuccessState) {
          AppAlert.success(message: state.message, context: context);
          cubit.clearAllData(context: context);
          AppFunctions.namedNavigateTo(
              context: context,
              navigatedScreen: RouteConstants.verificationCode);
        }

        if (state is RegisterErrorState) {
          AppAlert.error(message: state.error, context: context);
        }
        // if (state is GetUserProfileDataSuccessState) {
        //   AuthCubit.get(context).assignDataToController(
        //       data:
        //           AuthCubit.get(context).userModel?.data?.profile ?? Profile(),
        //       context: context);
        // }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                HeaderWidget(
                  backOnPressed: () {
                    if (CachedVariables.token == null) {
                      if (cubit.isProfile) {
                        AppFunctions.popNavigate(context: context);
                      } else {
                        cubit.changeShownProfile();
                      }
                    } else {
                      AppFunctions.popNavigate(context: context);
                    }
                  },
                  // todo : choose the right title depend on the localization
                  title: CachedVariables.token != null
                      ? AuthCubit.get(context).isProfile
                          ? AppStrings.editProfile
                          : AppStrings.mySports
                      : AppStrings.completeProfile,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (CachedVariables.token == null)
                          Row(
                            children: [
                              const Expanded(
                                child: StepperWidget(
                                  isSelected: true,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: StepperWidget(
                                  isSelected: cubit.isProfile ? false : true,
                                ),
                              ),
                            ],
                          ),
                        if (CachedVariables.token == null)
                          SizedBox(
                            height: 25.h,
                          ),
                        DetermineTitleWidget(isProfile: cubit.isProfile),
                        if (cubit.isProfile)
                          SizedBox(
                            height: 18.h,
                          ),
                        Expanded(
                          child: ListView(
                            controller: cubit.listviewController,
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            children: [
                              cubit.isProfile
                                  ? const UserFormWidget()
                                  : UserPreferredWidget(),
                              SizedBox(
                                height: 18.h,
                              ),
                            ],
                          ),
                        ),
                        // CachedVariables.token == null
                        //     ? const RegisterBottomsWidget()
                        //     : const EditProfileBottomsWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
