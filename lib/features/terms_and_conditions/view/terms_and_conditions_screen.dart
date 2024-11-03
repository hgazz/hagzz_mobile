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
    //   ..loadRequest(Uri.parse('https://hagzz.com/termsAndConditions.html'));

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
              initialUrl: 'https://hagzz.com/termsAndConditions.html',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (value) {
                AppFunctions.logPrint(message: "Valueee: ${value.toString()}");
              },
              onWebResourceError: (error) {
                AppFunctions.logPrint(message: "Error: ${error.toString()}");
              },
            ))
          ],
        ),
      ),
    );
  }
}
