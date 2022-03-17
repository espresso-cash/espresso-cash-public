import 'dart:math';

import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Sorted empty map is empty', () {
    final map = <Token, Amount>{};

    expect(map.sorted.isEmpty, true);
  });

  test(
    'The map is ordered by the strict positive balances first, '
    'precedence criteria is the not-null coinGeckoId '
    'and amount is the tiebraker',
    () async {
      final random = Random(1);
      const baseToken = Token.sol;
      final baseAmount = Amount.sol(value: 10);

      const token1 = baseToken;
      final amount1 = baseAmount;

      final token2 = baseToken.buildTestVariant(
        id: random.nextInt(100),
      );
      final amount2 = baseAmount.copyWith(value: 0);

      final token3 = baseToken.buildTestVariant(
        id: random.nextInt(100),
      );
      final amount3 = baseAmount.copyWith(value: -1);

      final token4 = baseToken.buildTestVariant(
        id: random.nextInt(100),
        hasCoinGeckoId: false,
      );
      final amount4 = baseAmount.copyWith(value: 15);

      final token5 = baseToken.buildTestVariant(
        id: random.nextInt(100),
        hasCoinGeckoId: false,
      );
      final amount5 = baseAmount.copyWith(value: 0);

      final tTokenMap = {
        token3: amount3,
        token4: amount4,
        token5: amount5,
        token2: amount2,
        token1: amount1,
      };

      final sorted = tTokenMap.sorted;

      expect(
        sorted.entries,
        pairwiseCompare<MapEntry<Token, Amount>, MapEntry<Token, Amount>>(
          [
            MapEntry(token1, amount1),
            MapEntry(token2, amount2),
            MapEntry(token3, amount3),
            MapEntry(token4, amount4),
            MapEntry(token5, amount5),
          ],
          (e1, e2) => e1.key == e2.key && e1.value == e2.value,
          'same token and amount',
        ),
      );
    },
  );
}

extension on Token {
  Token buildTestVariant({
    required int id,
    bool hasCoinGeckoId = true,
  }) =>
      Token(
        address: 'address $id',
        chainId: id,
        decimals: decimals,
        extensions: hasCoinGeckoId ? extensions : null,
        name: 'token $id',
        logoURI: logoURI,
        symbol: 'TK$id',
        tags: tags,
      );
}
