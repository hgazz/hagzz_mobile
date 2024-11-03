import 'package:bookit/core/util/constants/app_lottie/app_lottie.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';

import '../../../core/helper/router/rout_constants.dart';
import '../../../core/util/constants/app_functions/app_functions.dart';

class LostConnectionScreen extends StatefulWidget {
  const LostConnectionScreen({super.key});

  @override
  State<LostConnectionScreen> createState() => _LostConnectionScreenState();
}

class _LostConnectionScreenState extends State<LostConnectionScreen> {
  @override
  void initState() {
    InternetConnection().onStatusChange.listen((InternetStatus status) {
      AppFunctions.logPrint(message: "Statussss: $status");
      switch (status) {
        case InternetStatus.connected:
          AppFunctions.namedNavigateAndFinishTo(
              context: context, navigatedScreen: RouteConstants.bottomNavBar);
          break;
        case InternetStatus.disconnected:
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(AppLottie.wifi),
      ),
    );
  }
}
