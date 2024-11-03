import 'dart:developer';
import 'dart:io';

import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/util/constants/app_constants/app_constants.dart';
import 'package:bookit/core/util/constants/app_icons/app_icons.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:bookit/core/util/widgets/text_widgets/label_text_widget/label_text_widget.dart';
import 'package:bookit/core/util/widgets/text_widgets/title_text_widget/title_text_widget.dart';
import 'package:bookit/features/profile/view/widgets/bottom_sheet_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:popover/popover.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/api_models/error_response_model/error_response_model.dart';
import '../app_alert/app_alert.dart';
import '../app_colors/app_colors.dart';

class AppFunctions {
  static String translateText({required String text, required context}) =>
      text.tr(context: context);

  static logPrint({required String message}) => log(message);

  static popNavigate({required context}) => Navigator.pop(context);

  static namedNavigateTo(
          {required context, required String navigatedScreen, args}) =>
      Navigator.pushNamed(context, navigatedScreen, arguments: args);

  static namedNavigateAndFinishTo(
          {required context, required String navigatedScreen, args}) =>
      Navigator.pushNamedAndRemoveUntil(
          context, navigatedScreen, (route) => false,
          arguments: args);

  static Future<String> showMyDatePicker({required context}) async {
    String result = "";
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            minimumDate: DateTime(1960),
            maximumDate: DateTime(2018, 12, 31),
            initialDateTime: DateTime(2005, 1, 1),
            onDateTimeChanged: (DateTime value) {
              result = value.toString().split(" ")[0];
            },
          ),
        ),
      ),
    );

    if (result != "") {
      return result;
    } else {
      return '';
    }
  }

  static showPopupMenu({required context, required Widget widget}) =>
      showPopover(
        context: context,
        bodyBuilder: (context) => widget,
        onPop: () => print('Popover was popped!'),
        direction: PopoverDirection.bottom,
        width: 150.w,
        height: 200.h,
      );

  static showSuccessDialogBox(
          {required context,
          String? title,
          String? description,
          Widget? child}) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              content: Padding(
                padding: EdgeInsets.all(25.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppIcons.success),
                    TitleTextWidget(text: title ?? AppStrings.uAreIn),
                    LabelTextWidget(
                        text: description ?? AppStrings.signUpSuccessMessage),
                    if (child != null)
                      Padding(
                        padding: EdgeInsets.only(top: 32.0.h),
                        child: child,
                      )
                  ],
                ),
              ),
            );
          });

  static showBottomSheet(
          {required context,
          required Widget child,
          String? title,
          double? height}) =>
      showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.whiteBackground,
          builder: (context) => BottomSheetWidget(
                height: height ?? MediaQuery.of(context).size.height * 0.25,
                child: child,
                title: title,
              ));

  static String getStringFromList({required List item}) =>
      item.map((e) => e.name).join(', ');

  static launchMyUrl({required String url}) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      AppFunctions.logPrint(message: "Can't launch url");
      // can't launch url
    }
  }

  static String formatDateTimeFromString({required String date}) {
    AppFunctions.logPrint(message: "MyyyyyyyyyDate: $date");
    if (date != '') {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('E,d MMM', CachedVariables.lang).format(parsedDate);
    } else {
      return '';
    }
  }

  // format date to be like this "Friday August 11, 2023"
  static String formatDateTimeFromStringForSessionDetails(
      {required String date}) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('EEEE d MMMM , yyyy', CachedVariables.lang)
        .format(parsedDate);
  }

  static String convertTimeFormat(String time24) {
    try {
      final dateTime = DateTime.parse(
        "2022-01-01 $time24",
      );
      final hour = dateTime.hour;
      final minute = dateTime.minute;
      final second = dateTime.second;

      final format24 = DateFormat('HH:mm:ss').parse("$hour:$minute:$second");
      final format12 =
          DateFormat('h:mm a', CachedVariables.lang ?? 'en').format(format24);

      return format12;
    } catch (e) {
      AppFunctions.logPrint(message: "Error in time conversion: $e");
      return time24;
    }
  }

  static String getLevelImage(String level) {
    AppFunctions.logPrint(message: "Levelll: ${level}");
    switch (level.toLowerCase()) {
      case "beginner" || "مبتدئ":
        return AppIcons.beginnerSVG;
      case "intermediate" || "متوسط":
        return AppIcons.intermediateSVG;
      case "advanced" || "متقدم":
        return AppIcons.advancedSVG;
      default:
        return "";
    }
  }

  static Widget determineIcon(String icon) {
    if (icon.contains("assets/icons")) {
      return SvgPicture.asset(icon ?? '');
    } else {
      if (icon.contains(".svg")) {
        return SvgPicture.network(
          icon,
          height: 12.h,
        );
      } else {
        return Image.network(
          icon,
          height: 12.h,
          errorBuilder: (context, obj, _) {
            return Icon(
              Icons.error_outline,
              size: 12.h,
            );
          },
        );
      }
    }
  }

  static String getNotificationBottomString({required int type}) {
    switch (type) {
      case 0:
        return AppStrings.seeDetails;
      case 1:
        return AppStrings.seeDetails;
      case 2:
        return AppStrings.seeDetails;
      case 3:
        return AppStrings.getDirection;
      default:
        return "";
    }
  }

  static String getPlatformLink() =>
      Platform.isIOS ? AppConstants.iosLink : AppConstants.androidLink;

  static void shareApp({required context}) async {
    await Share.share(
      getPlatformLink(),
      subject: translateText(text: AppStrings.appName, context: context),
    );
  }

  static String convertTime(String time) {
    try {
      // Parse the original time string
      DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);

      // Format the parsed time to "HH:mm"
      String formattedTime = DateFormat("HH:mm").format(parsedTime);

      return formattedTime;
    } catch (e) {
      return time;
    }
  }

  static showError({required ErrorResponseModel error, required context}) {
    if (error.errors != null) {
      error.errors?.forEach((key, value) {
        AppAlert.error(message: value[0], context: context);
      });
    } else {
      AppAlert.error(message: error.message ?? '', context: context);
    }
  }

  static String convertToProperCase(String text) {
    return text
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  static void launchCoordinates(String latitude, String longitude) async {
    await MapsLauncher.launchCoordinates(
        double.parse(latitude), double.parse(longitude));
  }
}
