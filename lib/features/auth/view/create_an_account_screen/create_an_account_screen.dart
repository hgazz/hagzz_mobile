import 'package:bookit/features/auth/model/local_model/register_model.dart';
import 'package:bookit/features/auth/view/create_an_account_screen/widgets/already_have_an_account_widget/already_have_an_account_widget.dart';
import 'package:bookit/features/auth/view/create_an_account_screen/widgets/register_bottom_widget/register_bottoms_widget.dart';
import 'package:bookit/features/auth/view/create_an_account_screen/widgets/user_form_data_widget/user_form_data_widget.dart';
import 'package:bookit/features/auth/view_model/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/constants/app_functions/app_functions.dart';
import '../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../core/util/widgets/address_widget/view_model/address_cubit.dart';
import '../../../profile/view/widgets/header_widget.dart';

class CreateAnAccountScreen extends StatefulWidget {
  final RegisterModel? model;

  const CreateAnAccountScreen({super.key, this.model});

  @override
  State<CreateAnAccountScreen> createState() => _CreateAnAccountScreenState();
}

class _CreateAnAccountScreenState extends State<CreateAnAccountScreen> {
  @override
  void initState() {
    if (widget.model == null) {
      AddressCubit.get(context).selectedArea = null;
      AddressCubit.get(context).selectedCountry = null;
      AddressCubit.get(context).selectedCity = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit()
        ..assignDataIfTapToChange(data: widget.model, context: context)
        ..init(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          var cubit = RegisterCubit.get(context);

          if (state is RegisterInitial) {
            cubit.setGenderValidationError(context: context);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  HeaderWidget(
                    isShowBack: widget.model == null,
                    backOnPressed: () {
                      cubit.clearAllData(context: context);
                      AppFunctions.popNavigate(context: context);
                    },
                    // todo : choose the right title depend on the localization
                    title: AppStrings.createAnAccount,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UserFormDataWidget(),
                            SizedBox(
                              height: 16.h,
                            ),
                            RegisterBottomWidget(),
                            SizedBox(
                              height: 16.h,
                            ),
                            AlreadyHaveAnAccountWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
