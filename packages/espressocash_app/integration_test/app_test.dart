import 'package:espressocash_app/app/screens/authenticated/investments/investments_screen.dart';
import 'package:espressocash_app/features/onboarding/widgets/create_profile.dart';
import 'package:espressocash_app/features/sign_in/src/widgets/get_started_screen.dart';
import 'package:espressocash_app/features/sign_in/src/widgets/restore_account_screen.dart';
import 'package:espressocash_app/main.dart' as app;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

      await tester.pumpManual(6);

      // Should display Investment Screen
      final investmentScreen = find.byType(InvestmentsScreen);
      expect(investmentScreen, findsOneWidget);
    });

    testWidgets('Restore wallet', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      final recoverButton = find.byWidgetPredicate(
        (widget) => widget is RichText && tapTextSpan(widget, 'Continue here'),
      );

      // Tap on Restore Wallet option
      await tester.tap(recoverButton);
      await tester.pumpAndSettle();

      expect(find.byKey(keyRecoverMnemonic), findsOneWidget);

      // Enter dummy mnemonic
      await tester.enterText(find.byKey(keyRecoverMnemonic), dummyMnemonic);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.submit();

      // Enter 'Sample' as a name.
      await tester.enterText(find.byKey(keyCreateProfileName), 'Sample');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.submit();

      await tester.pumpManual(4);

      // Should display Investment Screen
      final investmentScreen = find.byType(InvestmentsScreen);
      expect(investmentScreen, findsOneWidget);
    });
  });
}

const dummyMnemonic =
    'action liquid forget crane ritual surface mind spoil siege walnut puzzle wave';

extension on WidgetTester {
  Future<void> submit() async {
    await tap(find.text('Next'));
    await pumpAndSettle();
  }

  Future<void> pumpManual(int times) async {
    for (int i = 0; i < times; i++) {
      await pump(const Duration(milliseconds: 500));
    }
  }
}

bool findTextAndTap(InlineSpan visitor, String text) {
  if (visitor is TextSpan && visitor.text == text) {
    (visitor.recognizer as TapGestureRecognizer).onTap?.call();

    return false;
  }

  return true;
}

bool tapTextSpan(RichText richText, String text) =>
    !richText.text.visitChildren(
      (visitor) => findTextAndTap(visitor, text),
    );
