import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/util/constants/app_colors/app_colors.dart';
import '../../../../../core/util/constants/app_icons/app_icons.dart';
import '../../../../../core/util/widgets/social_circle_widget/social_circle_widget.dart';

class AboutWidget extends StatelessWidget {
  final String facebookUrl;
  final String instagramUrl;
  final String linkedInmUrl;
  final String websiteUrl;

  const AboutWidget(
      {super.key,
      required this.facebookUrl,
      required this.instagramUrl,
      required this.linkedInmUrl,
      required this.websiteUrl});

  @override
  Widget build(BuildContext context) {
    AppFunctions.logPrint(message: "LinkedInnnn ${linkedInmUrl}");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        facebookUrl != ""
            ? SocialCircleWidget(
                onTap: () {
                  AppFunctions.logPrint(message: "$facebookUrl");

                  AppFunctions.launchMyUrl(url: facebookUrl);
                },
                icon: AppIcons.facebook,
                backgroundColor: AppColors.blue,
              )
            : SizedBox.shrink(),
        SizedBox(
          width: 10.w,
        ),
        instagramUrl != ''
            ? SocialCircleWidget(
                onTap: () {
                  AppFunctions.logPrint(message: "$instagramUrl");
                  AppFunctions.launchMyUrl(url: instagramUrl);
                },
                icon: AppIcons.instagram,
                backgroundColor: AppColors.ping,
              )
            : SizedBox.shrink(),
        SizedBox(
          width: 10.w,
        ),
        linkedInmUrl != ''
            ? SocialCircleWidget(
                onTap: () {
                  AppFunctions.logPrint(message: "Linkeddddd: $linkedInmUrl");
                  AppFunctions.launchMyUrl(url: linkedInmUrl);
                },
                icon: AppIcons.linkedin,
                backgroundColor: AppColors.LinkedIn,
              )
            : SizedBox.shrink(),
        SizedBox(
          width: 10.w,
        ),
        websiteUrl != ''
            ? SocialCircleWidget(
                onTap: () {
                  AppFunctions.logPrint(message: "Websiteeeeee: $websiteUrl");
                  AppFunctions.launchMyUrl(url: websiteUrl);
                },
                icon: AppIcons.website,
                backgroundColor: AppColors.greyColor.withOpacity(0.5),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
