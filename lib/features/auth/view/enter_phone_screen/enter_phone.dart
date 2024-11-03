import 'package:bookit/core/util/constants/app_images/app_images.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/label_text_widget/label_text_widget.dart';
import 'package:bookit/features/auth/view/enter_phone_screen/widgets/phone_bottom_widget/phone_bottom_keyboard_widget.dart';
import 'package:bookit/features/auth/view_model/enter_phone_cubit/enter_phone_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';

class EnterPhoneScreen extends StatelessWidget {
  const EnterPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => EnterPhoneCubit()..checkCachedPhone(),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(right: 15.r, left: 15.r),
          physics: BouncingScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 110.h,
            ),
            Center(
              child: SvgPicture.asset(AppImages.auth),
            ),
            SizedBox(
              height: 27.h,
            ),
            const TitleTextWidget(text: AppStrings.enterMobilePhone),
            SizedBox(
              height: 8.h,
            ),
            const LabelTextWidget(text: AppStrings.loginEnterPhoneLabel),
            SizedBox(
              height: 24.h,
            ),
            const PhoneBottomKeyboardWidget(),
            SizedBox(
              height: 63.h,
            )
          ],
        ),
      ),
    );
  }
}
