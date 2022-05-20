import 'dart:ui';

import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Correctly formats 44450 FROG', () {
    // ignore: avoid-non-null-assertion, cannot be null here
    final frogToken = TokenList(chainId: 101)
        .findTokenByMint('Amt5wUJREJQC5pX7Z48YSK812xmu4j3sQVupNhtsEuY8')!;
    final amount = Amount.fromToken(value: 44450000000, token: frogToken);
    expect(amount.format(const Locale('en')), '44,450.00 FROG');
  });
}
