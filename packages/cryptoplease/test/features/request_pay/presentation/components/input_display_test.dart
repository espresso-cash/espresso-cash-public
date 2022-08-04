import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/input_display.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Formats mask correctly on empty input value',
    (tester) async {
      await tester.pumpWidget(const _Wrapper(input: ''));

      final textFinder = find.text('0.00');

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Formats mask correctly on comma-only input value',
    (tester) async {
      await tester.pumpWidget(const _Wrapper(input: '.'));

      final textFinder = find.text('0.00');

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Formats mask correctly on zero as input value',
    (tester) async {
      await tester.pumpWidget(const _Wrapper(input: '0'));

      final textFinder = find.text('0.00');

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Formats mask correctly on zero-comma as input value',
    (tester) async {
      await tester.pumpWidget(const _Wrapper(input: '0.'));

      final textFinder = find.text('0.00');

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Formats mask correctly on unit integer as input value',
    (tester) async {
      await tester.pumpWidget(const _Wrapper(input: '1'));

      final textFinder = find.text('1.00');

      expect(textFinder, findsOneWidget);
    },
  );
  testWidgets(
    'Formats mask correctly on integer as input value',
    (tester) async {
      await tester.pumpWidget(const _Wrapper(input: '12'));

      final textFinder = find.text('12.00');

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Formats mask correctly on no-decimal as input value',
    (tester) async {
      await tester.pumpWidget(const _Wrapper(input: '12.'));

      final textFinder = find.text('12.00');

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Formats mask correctly on partially filled input value',
    (tester) async {
      await tester.pumpWidget(const _Wrapper(input: '12.2'));

      final textFinder = find.text('12.20');

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Formats mask correctly on fully filled input value',
    (tester) async {
      await tester.pumpWidget(const _Wrapper(input: '12.21'));

      final textFinder = find.text('12.21');

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Formats mask correctly on overflown input value',
    (tester) async {
      await tester.pumpWidget(const _Wrapper(input: '12.212'));

      final textFinder = find.text('12.212');

      expect(textFinder, findsOneWidget);
    },
  );
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({
    Key? key,
    required this.input,
  }) : super(key: key);

  final String input;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Localizations(
          delegates: AppLocalizations.localizationsDelegates,
          locale: const Locale('en'),
          child: InputDisplay(
            input: input,
            token: Token.usdc,
          ),
        ),
      );
}
