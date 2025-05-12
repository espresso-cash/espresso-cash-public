import 'dart:ui';

import 'package:espressocash_app/features/conversion_rates/widgets/extensions.dart';
import 'package:espressocash_app/features/currency/models/amount.dart';
import 'package:espressocash_app/features/tokens/token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Correctly formats 44450 MSI', () {
    const msiToken = Token(
      address: '2e7yNwrmTgXp9ABUmcPXvFJTSrEVLj4YMyrb4GUM4Pdd',
      chainId: 101,
      symbol: 'MSI',
      name: 'Matrix Solana Index',
      decimals: 6,
      logoURI:
          'https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2e7yNwrmTgXp9ABUmcPXvFJTSrEVLj4YMyrb4GUM4Pdd/logo.png',
      isStablecoin: false,
    );

    final amount = Amount.fromToken(value: 44_450_000_000, token: msiToken);
    expect(amount.format(const Locale('en')), '44,450.00 MSI');
  });
}
