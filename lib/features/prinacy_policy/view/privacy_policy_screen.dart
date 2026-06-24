import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/util/constants/app_functions/app_functions.dart';
import '../../profile/view/widgets/header_widget.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<PrivacyPolicyScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://hagzz.el7lm.com/privacy.html'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(
                backOnPressed: () {
                  AppFunctions.popNavigate(context: context);
                },
                title: ""),
            Expanded(child: WebViewWidget(controller: controller))
          ],
        ),
      ),
    );
  }
}
