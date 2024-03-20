import 'package:espressocash_app/features/sign_in/screens/get_started_screen.dart';
import 'package:espressocash_app/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Sign up flow', () {
    testWidgets('Creates wallet', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      // Tap on create wallet button.
      await tester.tap(find.byKey(keyCreateWalletButton));

      await tester.pumpManual(5);
    });
  });
}

extension on WidgetTester {
  Future<void> pumpManual(int times) async {
    for (int i = 0; i < times; i++) {
      await pump(const Duration(seconds: 1));
    }
  }
}
