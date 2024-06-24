import 'dart:ui';

import 'package:espressocash_app/features/conversion_rates/widgets/extensions.dart';
import 'package:espressocash_app/features/currency/models/amount.dart';
import 'package:espressocash_app/features/tokens/token_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Correctly formats 44450 MSI', () async {
    // ignore: avoid-non-null-assertion, cannot be null here
    final msiToken = await TokenList(chainId: 101)
        .getTokenByMint('2e7yNwrmTgXp9ABUmcPXvFJTSrEVLj4YMyrb4GUM4Pdd');

    if (msiToken == null) {
      throw Exception('Token not found');
    }

    final amount = Amount.fromToken(value: 44450000000, token: msiToken);
    expect(amount.format(const Locale('en')), '44,450.00 MSI');
  });
}
