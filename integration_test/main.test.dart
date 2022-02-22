import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:scratch_pad/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('End-to-end test', () {
    testWidgets('tap on the open reward button', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Finds the floating action button to tap on.
      final Finder openRewardButton = find.text('Open your reward');
      // Emulate a tap on the floating action button.
      await tester.tap(openRewardButton);
      await tester.pump(const Duration(seconds: 20));
      expect(
          find.text(
              'Wipe off the protective layer and put the free product in the shopping basket'),
          findsOneWidget);
    });
  });
}
