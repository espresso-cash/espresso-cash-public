import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import '../token_chart_item.dart';

const _maxAge = Duration(hours: 1);

@injectable
class TokenChartCache {
  TokenChartCache({
    required MyDatabase db,
  }) : _db = db;

  final MyDatabase _db;

  Future<List<TokenChartItem>?> get(String term) async {
    final now = DateTime.now();
    final query = _db.select(_db.tokenChartCacheRows)
      ..where((p) => p.query.equals(term))
      ..where(
        (p) => p.created.isBiggerOrEqualValue(
          now.subtract(_maxAge),
        ),
      );

    return query.get().then((row) => row.map((e) => e.toModel()).toList());
  }

  Future<void> set(String query, List<TokenChartItem> result) => _db.batch(
        (batch) {
          batch
            ..deleteWhere(
              _db.tokenChartCacheRows,
              (t) => t.query.equals(query),
            )
            ..insertAll(
              _db.tokenChartCacheRows,
              result.map((e) => e.toRow(query)),
            );
        },
      );

  Future<void> remove(String query) =>
      (_db.delete(_db.tokenChartCacheRows)..where((t) => t.query.equals(query)))
          .go();

  Future<void> clear() => _db.delete(_db.tokenChartCacheRows).go();
}

class TokenChartCacheRows extends Table with QueryMixin {
  DateTimeColumn get date => dateTime().nullable()();
  RealColumn get price => real().nullable()();
}

extension on TokenChartItem {
  TokenChartCacheRowsCompanion toRow(String query) =>
      TokenChartCacheRowsCompanion.insert(
        query: query,
        created: DateTime.now(),
        date: Value(date),
        price: Value(price),
      );
}

extension on TokenChartCacheRow {
  TokenChartItem toModel() => TokenChartItem(
        date: date,
        price: price,
      );
}
