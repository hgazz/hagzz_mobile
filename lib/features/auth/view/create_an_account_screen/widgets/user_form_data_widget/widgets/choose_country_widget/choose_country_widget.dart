import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/form_field_Widget/form_field_widget.dart';
import 'package:bookit/features/auth/view_model/register_cubit/register_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChooseCountryWidget extends StatelessWidget {
  const ChooseCountryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return FormFieldWidget(
            controller: cubit.countryController,
            hintText: AppStrings.selectYourCountry,
            keyInputType: TextInputType.none,
            onTap: () {
              // AppFunctions.showBottomSheet(
              //   context: context,
              //   child: child,
              // );
            },
            suffix: SvgPicture.asset(
              AppIcons.arrowDown,
              fit: BoxFit.scaleDown,
              height: 24,
              width: 24,
            ),
            validator: (value) {});
      },
    );
  }
}
