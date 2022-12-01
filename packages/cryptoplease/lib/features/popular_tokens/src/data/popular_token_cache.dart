import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/tokens/token.dart';
import '../../../../data/db/db.dart';

@injectable
class PopularTokenCache {
  PopularTokenCache(this._db);

  final MyDatabase _db;

  Future<IMap<Token, double>>? get() => _db
      .select(_db.popularTokenRows)
      .get()
      .then((rows) => IMap({for (var e in rows) e.toModel(): e.price}));

  Future<void> set(IMap<Token, double> result) async {
    await remove();

    await _db.batch((batch) {
      batch.insertAll(
        _db.popularTokenRows,
        result.entries.map((e) => e.key.toDto(e.value)).toList(),
      );
    });
  }

  Future<void> remove() => _db.delete(_db.popularTokenRows).go();
}

class PopularTokenRows extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get symbol => text()();
  TextColumn get logoUri => text().nullable()();
  RealColumn get price => real()();

  @override
  Set<Column<dynamic>>? get primaryKey => {id};
}

extension on Token {
  PopularTokenRow toDto(double price) => PopularTokenRow(
        id: extensions?.coingeckoId ?? name,
        name: name,
        symbol: symbol,
        logoUri: logoURI,
        price: price,
      );
}

extension on PopularTokenRow {
  Token toModel() => Token(
        name: name,
        symbol: symbol,
        logoURI: logoUri,
        extensions: Extensions(coingeckoId: id),
        address: id,
        chainId: 0,
        decimals: 0,
        tags: const [],
      );
}
