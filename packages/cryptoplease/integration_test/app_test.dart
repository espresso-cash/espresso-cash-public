import 'package:cryptoplease/app/components/recovery_phrase_text_view.dart';
import 'package:cryptoplease/features/onboarding/presentation/sign_up/create_profile_screen.dart';
import 'package:cryptoplease/features/onboarding/presentation/sign_up/get_started_screen.dart';
import 'package:cryptoplease/main.dart' as app;
import 'package:cryptoplease/ui/bottom_button.dart';
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
      await tester.pumpAndSettle();

      // Submit button should have 'I Understand' text, tap on it.
      await tester.tap(find.text('I Understand'));
      await tester.pumpAndSettle();

      // Ensure that recovery phrase is set.
      final recoveryPhrase = find.byWidgetPredicate(
        (widget) =>
            widget is RecoveryPhraseTextView && widget.phrase.isNotEmpty,
      );
      expect(recoveryPhrase, findsOneWidget);

      await tester.submit();

      // Enter 'Sample' as a name.
      await tester.enterText(find.byKey(keyCreateProfileName), 'Sample');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.submit();

      // Ensure that account was created and logged in – puzzle reminder
      // dialog will appear with 'Protect Your Wallet' title.
      final confirmationDialogTitle = find.text('Protect Your Wallet');
      expect(confirmationDialogTitle, findsOneWidget);
    });
  });
}

extension on WidgetTester {
  Future<void> submit() async {
    await tap(find.byKey(keyBottomButton));
    await pumpAndSettle();
  }
}
