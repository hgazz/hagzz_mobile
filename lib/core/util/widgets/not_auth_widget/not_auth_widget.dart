import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../helper/router/rout_constants.dart';
import '../../constants/app_functions/app_functions.dart';
import '../../constants/app_images/app_images.dart';
import '../../constants/app_strings/app_strings.dart';
import '../bottom_widget/bottom_widget.dart';

class NotAuthWidget extends StatelessWidget {
  const NotAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: SvgPicture.asset(AppImages.unAuth)),
        SizedBox(
          height: 25.h,
        ),
        BottomWidget(
            height: 43,
            text: AppStrings.login,
            onTap: () {
              // BottomNavBarCubit.get(context).changeIndex(0);
              AppFunctions.namedNavigateTo(
                  context: context, navigatedScreen: RouteConstants.enterPhone);
            },
            isLoading: false)
      ],
    );
  }
}
