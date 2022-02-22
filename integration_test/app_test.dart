import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:scratch_pad/main.dart';
import 'package:flutter/material.dart';

void main() {
  group('Testing scratch card', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Scenario 1: Scratch card test', (tester) async {
      final Finder openRewardButton = find.text('Open your reward');
      final scratchView = find.byKey(const Key('scratch_key'));

      await tester.pumpWidget(const MyApp());
      await tester.tap(openRewardButton);
      await tester.pump();

      await binding.watchPerformance(() async {
        await tester.fling(scratchView, const Offset(0, -100), 500);
        await tester.fling(scratchView, const Offset(50, -100), 500);
        await tester.fling(scratchView, const Offset(100, -100), 500);
        await tester.fling(scratchView, const Offset(200, -100), 500);
        await tester.fling(scratchView, const Offset(300, -100), 500);
        await tester.fling(scratchView, const Offset(0, 100), 500);
        await tester.fling(scratchView, const Offset(50, 100), 500);
        await tester.fling(scratchView, const Offset(100, 100), 500);
        await tester.fling(scratchView, const Offset(200, 100), 500);
        await tester.fling(scratchView, const Offset(300, 100), 500);
        await tester.fling(scratchView, const Offset(0, -100), 500);
        await tester.fling(scratchView, const Offset(-50, -100), 500);
        await tester.fling(scratchView, const Offset(-100, -100), 500);
        await tester.fling(scratchView, const Offset(-200, -100), 500);
        await tester.fling(scratchView, const Offset(-300, -100), 500);
        await tester.fling(scratchView, const Offset(0, 100), 500);
        await tester.fling(scratchView, const Offset(-50, 100), 500);
        await tester.fling(scratchView, const Offset(-100, 100), 500);
        await tester.fling(scratchView, const Offset(-200, 100), 500);
        await tester.fling(scratchView, const Offset(-300, 100), 500);
        await tester.pumpAndSettle(const Duration(seconds: 5));
      }, reportKey: 'scrolling_summary');
    });
  });
}
