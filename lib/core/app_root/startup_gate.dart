import 'package:flutter/material.dart';

/// Paints immediately, bounds initialization, and offers recovery on failure.
class StartupGate extends StatefulWidget {
  const StartupGate(
      {super.key,
      required this.initialize,
      required this.app,
      this.timeout = const Duration(seconds: 20)});
  final Future<void> Function() initialize;
  final Widget app;
  final Duration timeout;

  @override
  State<StartupGate> createState() => _StartupGateState();
}

class _StartupGateState extends State<StartupGate> {
  late Future<void> _startup;

  @override
  void initState() {
    super.initState();
    _startup = _initialize();
  }

  Future<void> _initialize() =>
      Future.sync(widget.initialize).timeout(widget.timeout);

  @override
  Widget build(BuildContext context) => FutureBuilder<void>(
        future: _startup,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            return widget.app;
          }
          final arabic =
              WidgetsBinding.instance.platformDispatcher.locale.languageCode ==
                  'ar';
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: SafeArea(
                    child: Center(
                        child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('Hagzz',
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                if (!snapshot.hasError) ...[
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(arabic ? 'جارٍ فتح التطبيق…' : 'Opening Hagzz…'),
                ] else ...[
                  Text(
                      arabic
                          ? 'تعذّر فتح التطبيق. حاول مرة أخرى.'
                          : 'Unable to open Hagzz. Please try again.',
                      textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () => setState(() {
                            _startup = _initialize();
                          }),
                      child: Text(arabic ? 'إعادة المحاولة' : 'Try again')),
                ],
              ]),
            )))),
          );
        },
      );
}
