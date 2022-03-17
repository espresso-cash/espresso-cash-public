import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/tokens/extensions.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/data/api/coingecko_client.dart';
import 'package:cryptoplease/data/conversion_rates_repository.dart';
import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'conversion_rates_provider_test.mocks.dart';

@GenerateMocks([CoingeckoClient])
void main() {
  final client = MockCoingeckoClient();

  tearDown(() {
    reset(client);
  });

  test('Buffers coingecko ids', () async {
    final dto1 = RateRequestDto(
      ids: ['a', 'b'].lock,
      vsCurrencies: ['USD'].lock,
    );
    final dto2 = RateRequestDto(ids: ['c'].lock, vsCurrencies: ['USD'].lock);

    when(client.getPrice(dto1)).thenAnswer(
      (_) async => {
        'a': const PricesMapDto(usd: 1.0),
        'b': const PricesMapDto(usd: 2.0),
      },
    );

    when(client.getPrice(dto2)).thenAnswer(
      (_) async => {
        'c': const PricesMapDto(usd: 3.0),
      },
    );

    const tokenA = Token(
      chainId: 0,
      address: 'a',
      symbol: 'a',
      name: 'a',
      decimals: 2,
      logoURI: null,
      tags: null,
      extensions: Extensions(coingeckoId: 'a'),
    );
    const tokenB = Token(
      chainId: 0,
      address: 'b',
      symbol: 'b',
      name: 'b',
      decimals: 2,
      logoURI: null,
      tags: null,
      extensions: Extensions(coingeckoId: 'b'),
    );
    const tokenC = Token(
      chainId: 0,
      address: 'c',
      symbol: 'c',
      name: 'c',
      decimals: 2,
      logoURI: null,
      tags: null,
      extensions: Extensions(coingeckoId: 'c'),
    );

    final repository = CoingeckoConversionRatesRepository(
      coingeckoClient: client,
      maxCoingeckoIds: 2,
    );
    await repository.refresh(Currency.usd, [tokenA, tokenB, tokenC]);

    expect(
      repository.readRate(
        const CryptoCurrency(token: tokenA),
        to: Currency.usd,
      ),
      Decimal.one,
    );
    expect(
      repository.readRate(
        const CryptoCurrency(token: tokenB),
        to: Currency.usd,
      ),
      Decimal.fromInt(2),
    );
    expect(
      repository.readRate(
        const CryptoCurrency(token: tokenC),
        to: Currency.usd,
      ),
      Decimal.fromInt(3),
    );
  });
}
