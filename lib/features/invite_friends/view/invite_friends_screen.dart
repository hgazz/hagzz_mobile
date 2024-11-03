import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/bottom_widget/bottom_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/custom_text_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/medium_text_widget/medium_text_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';
import 'package:bookit/features/profile/view/widgets/header_widget.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/util/constants/app_images/app_images.dart';
import '../../../core/util/widgets/rounded_image_widget/rounded_image_widget.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeaderWidget(
                titleFontSize: 22,
                titleFontWeight: FontWeight.bold,
                backOnPressed: () {
                  AppFunctions.popNavigate(context: context);
                },
                title: AppStrings.inviteFriend),
            SizedBox(
              height: 44.h,
            ),
            Expanded(
              child: Container(
                width: 343.w,
                height: 453.h,
                // color: Colors.red,
                child: Column(
                  children: [
                    const RoundedImageWidget(image: AppImages.logoInviteFriend),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      width: 296.w,
                      child: Column(
                        children: [
                          const TitleTextWidget(
                              text: AppStrings.inviteYourFriend),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            AppFunctions.translateText(
                                text: AppStrings.inviteFriendMessage,
                                context: context),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: GoogleFonts.inter(
                              color: AppColors.textGreyColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      height: 56.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.greyBorderColor),
                          borderRadius: BorderRadius.circular(30.r)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 11.w),
                              child: CustomTextWidget.server(
                                  text: AppFunctions.getPlatformLink(),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.lightGreyColor),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                await FlutterClipboard.copy(
                                        AppFunctions.getPlatformLink())
                                    .then((value) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: AppColors.onSurface,
                                    content: Text(AppFunctions.translateText(
                                        text: AppStrings.linkedCopy,
                                        context: context)),
                                    duration: Duration(seconds: 2),
                                  ));
                                });
                                AppFunctions.logPrint(
                                    message:
                                        "Daaaataaaa: ${await Clipboard.getData(AppFunctions.getPlatformLink())}");
                              },
                              icon: const Icon(
                                Icons.copy_rounded,
                                color: AppColors.black,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    BottomWidget(
                      text: "",
                      isLoading: false,
                      onTap: () {
                        AppFunctions.shareApp(context: context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share_outlined,
                            color: AppColors.black,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const MediumTextWidget(
                            text: AppStrings.shareLink,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
