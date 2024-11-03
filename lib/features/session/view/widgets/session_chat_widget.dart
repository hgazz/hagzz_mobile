import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_strings/app_strings.dart';
import 'package:flutter/material.dart';

class SessionChatWidget extends StatelessWidget {
  const SessionChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppFunctions.translateText(
          text: AppStrings.comingSoon, context: context)),
    );
  }
}
