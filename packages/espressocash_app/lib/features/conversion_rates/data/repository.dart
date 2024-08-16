import 'dart:async';

import 'package:async/async.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart' hide JupiterPriceClient;
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/db/db.dart';
import '../../../utils/async_cache.dart';
import '../../accounts/auth_scope.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import 'jupiter_client.dart';

@Singleton(scope: authScope)
class ConversionRatesRepository {
  ConversionRatesRepository({
    required MyDatabase db,
    required EspressoCashClient ecClient,
    required JupiterPriceClient jupiterClient,
  })  : _db = db,
        _ecClient = ecClient,
        _jupiterClient = jupiterClient {
    _initCache();
  }

  final MyDatabase _db;
  final JupiterPriceClient _jupiterClient;
  final EspressoCashClient _ecClient;
  final AsyncCache<void> _cache = AsyncCache(const Duration(minutes: 1));

  final Map<String, Map<String, Decimal>> _ratesCache = {};
  StreamSubscription<void>? _cacheSubscription;

  void _initCache() {
    _cacheSubscription =
        _db.select(_db.conversionRatesRows).watch().listen((rows) {
      for (final row in rows) {
        _ratesCache.putIfAbsent(
          row.fiatCurrency,
          () => {},
        )[row.token] = Decimal.tryParse(row.rate) ?? Decimal.zero;
      }
    });
  }

  Decimal? readRate(CryptoCurrency crypto, {required FiatCurrency to}) =>
      _ratesCache[to.symbol]?[crypto.token.address];

  Stream<Decimal?> watchRate(
    CryptoCurrency crypto, {
    required FiatCurrency to,
  }) {
    final query = _db.select(_db.conversionRatesRows)
      ..where(
        (tbl) =>
            tbl.token.equals(crypto.token.address) &
            tbl.fiatCurrency.equals(to.symbol),
      );

    return query
        .watchSingleOrNull()
        .map((row) => row?.rate.let(Decimal.tryParse));
  }

  AsyncResult<void> _fetchTokens(
    FiatCurrency currency,
    Iterable<Token> tokens,
  ) =>
      tryEitherAsync((_) async {
        final ids = await Stream.fromIterable(tokens.symbols)
            .bufferCount(_maxIds)
            .toList();

        final results = await Future.wait(
          ids.map((ids) async {
            final request = TokenRateRequestDto(ids: ids.lock);

            return _jupiterClient.getPrice(request);
          }),
        );

        final Map<String, TokenPricesMapDto> conversionRates = {};
        for (final element in results) {
          conversionRates.addAll(element.data);
        }

        final usdcRateQuery = _db.select(_db.conversionRatesRows)
          ..where(
            (tbl) =>
                tbl.token.equals(Currency.usdc.token.address) &
                tbl.fiatCurrency.equals(currency.symbol),
          );
        final usdcRateRow = await usdcRateQuery.getSingleOrNull();
        if (usdcRateRow == null) return;

        final usdcRate = Decimal.parse(usdcRateRow.rate);

        await _db.transaction(() async {
          for (final entry in conversionRates.entries) {
            final matchingTokens = tokens.where((t) => t.symbol == entry.key);

            final rate = Decimal.parse(entry.value.price.toString()) * usdcRate;

            for (final token in matchingTokens) {
              await _db.into(_db.conversionRatesRows).insert(
                    ConversionRatesRowsCompanion.insert(
                      token: token.address,
                      fiatCurrency: currency.symbol,
                      rate: rate.toString(),
                      updatedAt: DateTime.now(),
                    ),
                    mode: InsertMode.replace,
                  );
            }
          }
        });
      });

  AsyncResult<void> refresh(FiatCurrency currency, Iterable<Token> tokens) =>
      _cache.fetchEither(() async {
        final data = await _ecClient.getRates().then((p) => p.usdc);

        await _db.into(_db.conversionRatesRows).insert(
              ConversionRatesRowsCompanion.insert(
                token: Currency.usdc.token.address,
                fiatCurrency: currency.symbol,
                rate: data.toString(),
                updatedAt: DateTime.now(),
              ),
              mode: InsertMode.replace,
            );

        await _fetchTokens(currency, tokens);
      });

  @disposeMethod
  void dispose() {
    _cacheSubscription?.cancel();
  }
}

const _maxIds = 100;
