import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import '../token_details.dart';

const _maxAge = Duration(hours: 6);

@injectable
class TokenDetailsCache {
  TokenDetailsCache({
    required MyDatabase db,
  }) : _db = db;

  final MyDatabase _db;

  Future<TokenDetails?> get(String id) async {
    final now = DateTime.now();
    final query = _db.select(_db.tokenDetailsCacheRows)
      ..where((p) => p.id.equals(id))
      ..where(
        (p) => p.created.isBiggerOrEqualValue(
          now.subtract(_maxAge),
        ),
      );

    return query.getSingleOrNull().then((row) => row?.toModel());
  }

  Future<void> set(String id, TokenDetails result) => _db
      .into(_db.tokenDetailsCacheRows)
      .insert(result.toDto(id), mode: InsertMode.replace);

  Future<void> remove(String id) =>
      (_db.delete(_db.tokenDetailsCacheRows)..where((t) => t.id.equals(id)))
          .go();

  Future<void> clear() => _db.delete(_db.tokenDetailsCacheRows).go();
}

class TokenDetailsCacheRows extends Table with EntityMixin {
  TextColumn get name => text()();
  TextColumn get description => text()();
  RealColumn get marketPrice => real().nullable()();
  IntColumn get marketCapRank => integer().nullable()();
}

extension on TokenDetails {
  TokenDetailsCacheRow toDto(String id) => TokenDetailsCacheRow(
        id: id,
        name: name,
        description: description,
        marketPrice: marketPrice,
        marketCapRank: marketCapRank,
        created: DateTime.now(),
      );
}

extension on TokenDetailsCacheRow {
  Future<TokenDetails>? toModel() async => TokenDetails(
        name: name,
        description: description,
        marketPrice: marketPrice,
        marketCapRank: marketCapRank,
      );
}
