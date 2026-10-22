import 'dart:async';
import 'package:bookit/core/app_root/startup_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const ready = MaterialApp(home: Text('Application ready'));

  testWidgets('first frame appears while initialization is pending',
      (tester) async {
    final pending = Completer<void>();
    await tester
        .pumpWidget(StartupGate(initialize: () => pending.future, app: ready));
    expect(find.text('Opening Hagzz…'), findsOneWidget);
    pending.complete();
    await tester.pumpAndSettle();
    expect(find.text('Application ready'), findsOneWidget);
  });

  testWidgets('initialization failure offers retry and recovers',
      (tester) async {
    var attempts = 0;
    await tester.pumpWidget(StartupGate(
        initialize: () async {
          if (++attempts == 1) throw StateError('storage unavailable');
        },
        app: ready));
    await tester.pumpAndSettle();
    expect(find.text('Try again'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text('Application ready'), findsOneWidget);
    expect(attempts, 2);
  });

  testWidgets(
      'hung initialization becomes actionable instead of endless loading',
      (tester) async {
    final pending = Completer<void>();
    await tester.pumpWidget(StartupGate(
        initialize: () => pending.future,
        app: ready,
        timeout: const Duration(seconds: 2)));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Try again'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    pending.complete();
    await tester.pumpAndSettle();
    // A late completion must not silently replace the recovery screen.
    expect(find.text('Try again'), findsOneWidget);
  });
}
