import 'package:bookit/core/helper/router/rout_constants.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/features/auth/model/local_model/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_strings/app_strings.dart';
import '../../../../../core/util/widgets/text_widgets/label_text_widget/label_text_widget.dart';
import '../../../../../core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';

class HeaderVerificationPasswordCommonWidget extends StatelessWidget {
  final String titleText;
  final String phone;
  final String code;
  final bool isLogin;
  final RegisterModel? registerModel;

  const HeaderVerificationPasswordCommonWidget(
      {super.key,
      required this.titleText,
      required this.phone,
      required this.code,
      required this.isLogin,
      required this.registerModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextWidget(text: titleText),
        SizedBox(
          height: 8.h,
        ),
        const LabelTextWidget(text: AppStrings.verificationCodeMessage),
        Row(
          children: [
            LabelTextWidget(text: "$code$phone"),
            SizedBox(
              width: 4.w,
            ),
            InkWell(
                onTap: () {
                  if (isLogin) {
                    AppFunctions.popNavigate(context: context);
                  } else {
                    AppFunctions.namedNavigateAndFinishTo(
                        context: context,
                        navigatedScreen: RouteConstants.createAnAccount,
                        args: registerModel);
                  }
                },
                child: const LabelTextWidget(
                  text: AppStrings.tapToChange,
                  textDecoration: TextDecoration.underline,
                  isBold: true,
                ))
          ],
        ),
      ],
    );
  }
}
