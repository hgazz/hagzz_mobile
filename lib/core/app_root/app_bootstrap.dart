import 'dart:async';

import 'package:flutter/widgets.dart';

/// Only local prerequisites may delay navigation. Telemetry starts after it.
class AppBootstrap {
  AppBootstrap({
    required this.initializeLocal,
    required this.initializeOptional,
    required this.onOptionalError,
    this.optionalTimeout = const Duration(seconds: 15),
  });

  final Future<void> Function() initializeLocal;
  final Future<void> Function() initializeOptional;
  final void Function(Object, StackTrace) onOptionalError;
  final Duration optionalTimeout;
  bool _optionalScheduled = false;

  Future<void> initialize() async {
    await initializeLocal();
    if (_optionalScheduled) return;
    _optionalScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_startOptional());
    });
  }

  Future<void> _startOptional() async {
    try {
      await Future.sync(initializeOptional).timeout(optionalTimeout);
    } catch (error, stack) {
      // Reporting itself must not turn a telemetry failure into an app failure.
      try {
        onOptionalError(error, stack);
      } catch (_) {
        debugPrint('Unable to report optional startup failure');
      }
    }
  }
}
