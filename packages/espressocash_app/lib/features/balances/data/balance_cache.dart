import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../core/currency.dart';
import '../../../data/db/db.dart';

@injectable
class BalanceCache {
  const BalanceCache(this._db);

  final MyDatabase _db;

  Future<void> clear() => _db.delete(_db.usdcCacheRows).go();

  Future<void> saveBalance(int balance) =>
      _db.into(_db.usdcCacheRows).insertOnConflictUpdate(
            UsdcCacheRowsCompanion(
              id: const Value('usdc'),
              balance: Value(balance),
            ),
          );

  Future<void> saveRate({
    required double rate,
    required FiatCurrency currency,
  }) =>
      _db.into(_db.usdcCacheRows).insertOnConflictUpdate(
            UsdcCacheRowsCompanion(
              id: const Value('usdc'),
              rate: Value(rate),
              currency: Value(currency.symbol),
            ),
          );

  Future<int?> fetchBalance() =>
      _db.select(_db.usdcCacheRows).getSingleOrNull().then(
            (row) => row?.balance,
          );

  Future<(double, FiatCurrency)?> fetchRate() =>
      _db.select(_db.usdcCacheRows).getSingleOrNull().then(
        (row) {
          final rate = row?.rate;
          final currency = row?.currency;

          return rate == null || currency == null
              ? null
              : (rate, currencyFromString(currency));
        },
      );
}
