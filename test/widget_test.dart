import 'dart:async';

import 'package:bookit/core/app_root/app_bootstrap.dart';
import 'package:bookit/core/app_root/startup_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const app = MaterialApp(home: Text('Application ready'));

  testWidgets('a hung optional SDK does not block opening the app',
      (tester) async {
    final pending = Completer<void>();
    final errors = <Object>[];
    var optionalCalls = 0;
    final bootstrap = AppBootstrap(
      initializeLocal: () async {},
      initializeOptional: () {
        optionalCalls++;
        return pending.future;
      },
      onOptionalError: (error, stack) => errors.add(error),
      optionalTimeout: const Duration(seconds: 2),
    );
    await tester
        .pumpWidget(StartupGate(initialize: bootstrap.initialize, app: app));
    await tester.pumpAndSettle();
    expect(find.text('Application ready'), findsOneWidget);
    expect(optionalCalls, 1);
    await tester.pump(const Duration(seconds: 3));
    expect(errors.single, isA<TimeoutException>());
    expect(find.text('Application ready'), findsOneWidget);
    pending.complete();
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('a failing optional SDK does not replace the ready app',
      (tester) async {
    final errors = <Object>[];
    final bootstrap = AppBootstrap(
      initializeLocal: () async {},
      initializeOptional: () async => throw StateError('SDK unavailable'),
      onOptionalError: (error, stack) => errors.add(error),
    );
    await tester
        .pumpWidget(StartupGate(initialize: bootstrap.initialize, app: app));
    await tester.pumpAndSettle();
    expect(find.text('Application ready'), findsOneWidget);
    expect(errors.single, isA<StateError>());
    expect(tester.takeException(), isNull);
  });

  testWidgets('local recovery starts optional services only once',
      (tester) async {
    var localCalls = 0;
    var optionalCalls = 0;
    final errors = <Object>[];
    final bootstrap = AppBootstrap(
      initializeLocal: () async {
        if (++localCalls == 1) throw StateError('local storage unavailable');
      },
      initializeOptional: () async {
        optionalCalls++;
      },
      onOptionalError: (error, stack) => errors.add(error),
    );
    await tester
        .pumpWidget(StartupGate(initialize: bootstrap.initialize, app: app));
    await tester.pumpAndSettle();
    expect(find.text('Try again'), findsOneWidget);
    expect(optionalCalls, 0);
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text('Application ready'), findsOneWidget);
    expect(localCalls, 2);
    expect(optionalCalls, 1);
    await bootstrap.initialize();
    await tester.pump();
    expect(optionalCalls, 1);
    expect(errors, isEmpty);
  });
}
