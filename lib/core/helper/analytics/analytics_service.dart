import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  static final readiness = ValueNotifier<bool>(false);

  static bool get isReady => readiness.value && Firebase.apps.isNotEmpty;

  static FirebaseAnalyticsObserver? get observer => isReady
      ? FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
      : null;

  static Future<void> initialize() async {
    // Keep product analytics; do not grant advertising consent for analytics.
    await FirebaseAnalytics.instance
        .setConsent(
          adStorageConsentGranted: false,
          adUserDataConsentGranted: false,
          adPersonalizationSignalsConsentGranted: false,
        )
        .timeout(const Duration(seconds: 5));
    readiness.value = true;
  }

  static Future<void> _send(
      Future<void> Function(FirebaseAnalytics) action) async {
    if (!isReady) return;
    try {
      await action(FirebaseAnalytics.instance)
          .timeout(const Duration(seconds: 5));
    } catch (error) {
      debugPrint('Analytics event unavailable: ${error.runtimeType}');
    }
  }

  static Future<void> logLogin() =>
      _send((analytics) => analytics.logLogin(loginMethod: 'phone_otp'));

  static Future<void> logSignUp() =>
      _send((analytics) => analytics.logSignUp(signUpMethod: 'phone_otp'));

  static Future<void> logBookingSuccess({
    required int sessionId,
    required String sessionName,
    required double price,
    required String orderId,
  }) async {
    await _send((analytics) => analytics.logPurchase(
          transactionId: orderId,
          value: price,
          currency: 'EGP',
          items: [
            AnalyticsEventItem(
              itemId: sessionId.toString(),
              itemName: sessionName,
              itemCategory: 'training_session',
              price: price,
            ),
          ],
        ));
  }

  static Future<void> logSearch({required String searchTerm}) =>
      _send((analytics) => analytics.logSearch(searchTerm: searchTerm));

  static Future<void> logScreenView({required String screenName}) =>
      _send((analytics) => analytics.logScreenView(screenName: screenName));

  static Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) =>
      _send((analytics) =>
          analytics.logEvent(name: name, parameters: parameters));
}
