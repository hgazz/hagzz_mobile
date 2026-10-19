import 'package:bookit/features/home/view/widgets/mobile_catalog/mobile_catalog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> catalog(String country) => {
      'is_demo': true,
      'bookable': false,
      'academies': [
        {
          'key': country,
          'name': 'Academy $country',
          'name_ar': 'Academy $country',
          'sport_en': 'Swimming',
          'sport_ar': 'Swimming',
          'location': 'Demo pool',
          'coach': 'Fictional coach',
          'trainings': [
            {
              'name_en': 'Demo training',
              'price': 400,
              'currency': country == 'qa' ? 'QAR' : 'EGP',
              'sessions': 4,
              'weekdays_ar': 'Saturday',
              'weekdays_en': 'Saturday',
              'start_time': '16:00',
              'end_time': '17:00',
              'start_date': '2026-10-24',
              'end_date': '2026-11-14',
              'timezone': country == 'qa' ? 'Asia/Qatar' : 'Africa/Cairo'
            }
          ]
        }
      ]
    };

void main() {
  testWidgets(
      'shows server data and country-specific prices without booking controls',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final requested = <String>[];
    await tester.pumpWidget(
        MaterialApp(home: MobileCatalogScreen(loader: (country) async {
      requested.add(country);
      return catalog(country);
    })));
    await tester.pumpAndSettle();
    expect(find.text('Academy eg'), findsOneWidget);
    await tester.tap(find.text('Academy eg'));
    await tester.pumpAndSettle();
    expect(find.textContaining('400 EGP'), findsOneWidget);
    expect(find.textContaining('Fictional coach'), findsOneWidget);
    expect(
        find.textContaining('booking and payment unavailable'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNothing);
    await tester.tap(find.byKey(const Key('catalog-country')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Qatar — QAR').last);
    await tester.pumpAndSettle();
    expect(find.text('Academy qa'), findsOneWidget);
    expect(find.text('Academy eg'), findsNothing);
    await tester.tap(find.text('Academy qa'));
    await tester.pumpAndSettle();
    expect(find.textContaining('400 QAR'), findsOneWidget);
    expect(find.text('Asia/Qatar'), findsOneWidget);
    expect(requested, ['eg', 'qa']);
  });

  testWidgets('failed API request can be retried', (tester) async {
    var requests = 0;
    await tester.pumpWidget(
        MaterialApp(home: MobileCatalogScreen(loader: (country) async {
      if (++requests == 1) throw Exception('offline');
      return catalog(country);
    })));
    await tester.pumpAndSettle();
    expect(find.text('Unable to load catalog'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Academy eg'), findsOneWidget);
    expect(requests, 2);
  });
}
