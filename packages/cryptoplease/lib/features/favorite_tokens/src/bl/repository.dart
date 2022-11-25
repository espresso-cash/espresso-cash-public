import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/tokens/token.dart';
import '../../../../data/db/db.dart';

@injectable
class FavoriteTokenRepository {
  FavoriteTokenRepository(this._db);

  final MyDatabase _db;

  Future<void> add(Token token) async {
    await _db.into(_db.favoriteTokenRows).insert(token.toDto());
  }

  Future<void> remove(Token token) async {
    final query = _db.delete(_db.favoriteTokenRows)
      ..where((p) => p.id.equals(token.extensions?.coingeckoId ?? token.name));

    await query.go();
  }

  Stream<List<Token>> watch() {
    final query = _db.select(_db.favoriteTokenRows);

    return query.watch().map((e) => e.map((e) => e.toModel()).toList());
  }

  Future<List<Token>> fetch() async {
    final query = _db.select(_db.favoriteTokenRows);

    return query.get().then((e) => e.map((e) => e.toModel()).toList());
  }

  Future<bool> isFavorite(Token token) {
    final query = _db.select(_db.favoriteTokenRows)
      ..where((p) => p.id.equals(token.extensions?.coingeckoId ?? token.name));

    return query.getSingleOrNull().then((p) => p != null);
  }

  Future<void> clear() => _db.delete(_db.favoriteTokenRows).go();
}

class FavoriteTokenRows extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get symbol => text()();
  TextColumn get logoUri => text().nullable()();
  DateTimeColumn get created => dateTime()();

  @override
  Set<Column<dynamic>>? get primaryKey => {id};
}

extension on Token {
  FavoriteTokenRow toDto() => FavoriteTokenRow(
        id: extensions?.coingeckoId ?? name,
        name: name,
        symbol: symbol,
        logoUri: logoURI,
        created: DateTime.now(),
      );
}

extension on FavoriteTokenRow {
  Token toModel() => Token(
        name: name,
        symbol: symbol,
        logoURI: logoUri,
        chainId: 0,
        address: id,
        decimals: 0,
        extensions: Extensions(coingeckoId: id),
        tags: const [],
      );
}
