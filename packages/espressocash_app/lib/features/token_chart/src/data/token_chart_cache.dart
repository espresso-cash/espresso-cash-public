import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import '../token_chart_item.dart';

const _maxAge = Duration(minutes: 3);

@injectable
class TokenChartCache {
  TokenChartCache({
    required MyDatabase db,
  }) : _db = db;

  final MyDatabase _db;

  Future<List<TokenChartItem>?> get(String id) async {
    final query = _db.select(_db.tokenChartRows)..where((p) => p.id.equals(id));

    final row = await query.getSingleOrNull();

    if (row != null) {
      final now = DateTime.now();

      if (now.difference(row.created) <= _maxAge) {
        return row.toModel();
      } else {
        await remove(id);
      }
    }
  }

  Future<void> set(String id, List<TokenChartItem> result) => _db
      .into(_db.tokenChartRows)
      .insert(result.toDto(id), mode: InsertMode.replace);

  Future<void> remove(String id) =>
      (_db.delete(_db.tokenChartRows)..where((t) => t.id.equals(id))).go();

  Future<void> clear() => _db.delete(_db.tokenChartRows).go();
}

class TokenChartRows extends Table with EntityMixin {
  TextColumn get data => text()();
}

extension on List<TokenChartItem> {
  TokenChartRow toDto(String id) => TokenChartRow(
        id: id,
        created: DateTime.now(),
        data: json.encode(map((e) => e.toJson()).toList()),
      );
}

extension on TokenChartRow {
  Future<List<TokenChartItem>>? toModel() async {
    final list = json.decode(data) as List;

    return list
        .map((e) => TokenChartItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
