import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/features/profile/view/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            AppFunctions.logPrint(message: "Error: ${error.toString()}");
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://hagzz.el7lm.com/termsAndConditions.html'),
      );
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
