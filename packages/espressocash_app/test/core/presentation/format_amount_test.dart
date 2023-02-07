import 'dart:ui';

import 'package:espressocash_app/core/amount.dart';
import 'package:espressocash_app/core/presentation/format_amount.dart';
import 'package:espressocash_app/core/tokens/token_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Correctly formats 44450 MSI', () {
    // ignore: avoid-non-null-assertion, cannot be null here
    final msiToken = TokenList(chainId: 101)
        .findTokenByMint('2e7yNwrmTgXp9ABUmcPXvFJTSrEVLj4YMyrb4GUM4Pdd')!;
    final amount = Amount.fromToken(value: 44450000000, token: msiToken);
    expect(amount.format(const Locale('en')), '44,450.00 MSI');
  });
}
