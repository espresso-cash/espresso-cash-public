// ignore_for_file: always_use_package_imports, avoid-banned-imports

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../core/conversion_rates/bl/conversion_rates_client.dart';
import '../../../data/db/db.dart';
import '../../../data/db/mixins.dart';

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
    final Map<String, PricesMapDto> result = {};

    for (final id in ids) {
      final query = _db.select(_db.priceCacheRows)
        ..where((p) => p.id.equals(id));

      final row = await query.getSingleOrNull();

      if (row != null) {
        final now = DateTime.now();

        if (now.difference(row.created) <= _maxAge) {
          result[id] = PricesMapDto(
            usd: row.usd,
            eur: row.eur,
          );
        } else {
          await remove(id);
        }
      }
    }

    return result;
  }

  Future<void> set({
    required Map<String, PricesMapDto> data,
  }) =>
      _db.transaction(() async {
        await _db.batch((batch) {
          batch.insertAll(
            _db.priceCacheRows,
            data.entries.map(
              (e) => PriceCacheRow(
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
      (_db.delete(_db.priceCacheRows)..where((t) => t.id.equals(id))).go();

  Future<void> clear() => _db.delete(_db.priceCacheRows).go();
}

class PriceCacheRows extends Table with EntityMixin {
  RealColumn get usd => real().nullable()();
  RealColumn get eur => real().nullable()();
}
