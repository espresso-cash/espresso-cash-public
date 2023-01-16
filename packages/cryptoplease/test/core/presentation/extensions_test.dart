import 'dart:ui';

import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/presentation/extensions.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final Map<Decimal?, String> inputs = {
    Decimal.one: r'$1.00',
    Decimal.parse('12.3'): r'$12.30',
    Decimal.parse('12.345'): r'$12.35',
    Decimal.parse('0.12345'): r'$0.12',
    Decimal.parse('0.01'): r'$0.01',
    Decimal.parse('0.0001'): r'$0.0001',
    Decimal.parse('0.000000001'): r'$0.00',
    Decimal.parse('0.000000123'): r'$0.0000001',
    null: '-',
  };

  for (final input in inputs.entries) {
    test('Formats ${input.key} as ${input.value}', () {
      expect(
        input.key.formatDisplayablePrice(
          locale: const Locale('en'),
          currency: Currency.usd,
        ),
        input.value,
      );
    });
  }
}
