import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final _analytics = FirebaseAnalytics.instance;

  static FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  static Future<void> logLogin() =>
      _analytics.logLogin(loginMethod: 'phone_otp');

  static Future<void> logSignUp() =>
      _analytics.logSignUp(signUpMethod: 'phone_otp');

  static Future<void> logBookingSuccess({
    required int sessionId,
    required String sessionName,
    required double price,
    required String orderId,
  }) async {
    await _analytics.logPurchase(
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
    );
  }

  static Future<void> logSearch({required String searchTerm}) =>
      _analytics.logSearch(searchTerm: searchTerm);

  static Future<void> logScreenView({required String screenName}) =>
      _analytics.logScreenView(screenName: screenName);

  static Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) =>
      _analytics.logEvent(name: name, parameters: parameters);
}
