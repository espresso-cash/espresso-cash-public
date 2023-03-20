import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import 'conversion_rates_client.dart';

const _maxAge = Duration(minutes: 1);

@injectable
class TokenPriceCache {
  TokenPriceCache({
    required MyDatabase db,
  }) : _db = db;

  final MyDatabase _db;

  Future<Map<String, PricesMapDto>> get(
    List<String> ids,
  ) async {
    final now = DateTime.now();
    final result = <String, PricesMapDto>{};

    final query = _db.select(_db.tokenPriceCacheRows)
      ..where((p) => p.id.isIn(ids))
      ..where((p) => p.created.isBiggerOrEqualValue(now.subtract(_maxAge)));

    final rows = await query.get();

    for (final row in rows) {
      result[row.id] = PricesMapDto(usd: row.usd, eur: row.eur);
    }

    return result;
  }

  Future<void> set({
    required Map<String, PricesMapDto> data,
  }) =>
      _db.transaction(() async {
        await _db.batch((batch) {
          batch.insertAll(
            _db.tokenPriceCacheRows,
            data.entries.map(
              (e) => TokenPriceCacheRow(
                id: e.key,
                usd: e.value.usd,
                eur: e.value.eur,
                created: DateTime.now(),
              ),
            ),
            mode: InsertMode.replace,
          );
        });
      });

  Future<void> remove(String id) =>
      (_db.delete(_db.tokenPriceCacheRows)..where((t) => t.id.equals(id))).go();

  Future<void> clear() => _db.delete(_db.tokenPriceCacheRows).go();
}

class TokenPriceCacheRows extends Table with EntityMixin {
  RealColumn get usd => real().nullable()();
  RealColumn get eur => real().nullable()();
}
