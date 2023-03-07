import 'package:decimal/decimal.dart';
import 'package:espressocash_app/core/conversion_rates/bl/conversion_rates_client.dart';
import 'package:espressocash_app/core/conversion_rates/bl/repository.dart';
import 'package:espressocash_app/core/conversion_rates/bl/token_price_cache.dart';
import 'package:espressocash_app/core/currency.dart';
import 'package:espressocash_app/core/tokens/token.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'conversion_rates_provider_test.mocks.dart';

@GenerateMocks([ConversionRatesClient, TokenPriceCache])
void main() {
  final client = MockConversionRatesClient();
  final cacheClient = MockTokenPriceCache();

  tearDown(() {
    reset(client);
    reset(cacheClient);
  });

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

    when(cacheClient.get(any)).thenAnswer((_) async => {});

    final repository = ConversionRatesRepository.test(
      coingeckoClient: client,
      tokenPriceCache: cacheClient,
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

  test('Cache is used when valid', () async {
    when(cacheClient.get(['a', 'b', 'c'])).thenAnswer(
      (_) async => {
        'c': const PricesMapDto(usd: 3.0),
      },
    );

    final dto = RateRequestDto(
      ids: ['a', 'b'].lock,
      vsCurrencies: ['USD'].lock,
    );

    when(client.getPrice(dto)).thenAnswer(
      (_) async => {
        'a': const PricesMapDto(usd: 1.0),
        'b': const PricesMapDto(usd: 2.0),
      },
    );

    final repository = ConversionRatesRepository.test(
      coingeckoClient: client,
      tokenPriceCache: cacheClient,
      maxCoingeckoIds: 30,
    );
    await repository.refresh(Currency.usd, [tokenA, tokenB, tokenC]);

    verify(
      client.getPrice(dto),
    );
    verifyNever(
      client.getPrice(
        RateRequestDto(
          ids: ['a', 'b', 'c'].lock,
          vsCurrencies: ['USD'].lock,
        ),
      ),
    );
  });
}
