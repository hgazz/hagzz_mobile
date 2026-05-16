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
  late WebViewController controller;

  @override
  void initState() {
    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith('https://www.youtube.com/')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse('https://hagzz.el7lm.com/privacy.html'));

    super.initState();
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
            Expanded(
              child: WebView(
                initialUrl: "https://hagzz.el7lm.com/privacy.html",
                javascriptMode: JavascriptMode.unrestricted,
              ),
            )
          ],
        ),
      ),
    );
  }
}
