import 'package:bookit/core/helper/analytics/analytics_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('events and observer are safe before Firebase is available', () async {
    expect(AnalyticsService.isReady, isFalse);
    expect(AnalyticsService.observer, isNull);
    await AnalyticsService.logLogin();
    await AnalyticsService.logSignUp();
    await AnalyticsService.logSearch(searchTerm: 'football');
    await AnalyticsService.logScreenView(screenName: 'home');
    await AnalyticsService.logEvent(name: 'startup');
    await AnalyticsService.logBookingSuccess(
        sessionId: 1, sessionName: 'training', price: 10, orderId: 'test');
    expect(AnalyticsService.isReady, isFalse);
  });
}
