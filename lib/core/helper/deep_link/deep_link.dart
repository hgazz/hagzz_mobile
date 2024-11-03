// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:original_base/original_base.dart';
//
// //----------------------------------------------------
//
// class ProductDynamicLinkService {
//   final _instance = FirebaseDynamicLinks.instance;
//
//   Future<void> initDynamicLinks() async {
//     // wait for 2 seconds to make sure link is not null.
//     await Future.delayed(Duration(seconds: 2));
//
//     try {
//       var initialLink = await _instance.getInitialLink();
//       if (initialLink != null) {
//         Map params = initialLink.link.queryParameters;
//         int productId = int.parse(params["id"]);
//         _navigateToProductScreen(productId);
//       }
//
//       _instance.onLink.listen((event) {
//         Map params = event.link.queryParameters;
//         int productId = int.parse(params["id"]);
//         _navigateToProductScreen(productId);
//       });
//     } catch (error, stack) {
//       FirebaseCrashlytics.instance.recordError(error, stack);
//     }
//   }
//
//   Future<Uri> createDynamicLink(int productId) async {
//     final rootUrl = "https://originaltwo.page.link";
//     var dynamicLinkParams = DynamicLinkParameters(
//       uriPrefix: rootUrl,
//       link: Uri.parse("$rootUrl/products?id=$productId"),
//       androidParameters: const AndroidParameters(
//         packageName: "com.bookit.bookit",
//       ),
//       iosParameters: const IOSParameters(
//         bundleId: "com.unlimited.bookit",
//       ),
//     );
//
//     var dynamicLink = await _instance.buildShortLink(dynamicLinkParams);
//     return dynamicLink.shortUrl;
//   }
//
//   Future<void> _navigateToProductScreen(int productId) async {
//     var product = await SingleProductClient().fetchProduct(productId);
//     Sailor.toNamed(
//       Routes.product,
//       args: {"product": product},
//     );
//   }
// }
