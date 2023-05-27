import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/tokens/token.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../data/db/db.dart';

@injectable
class FavoriteTokenRepository {
  FavoriteTokenRepository({
    required MyDatabase database,
    required TokenList tokenList,
  })  : _db = database,
        _tokenList = tokenList;

  final MyDatabase _db;
  final TokenList _tokenList;

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

    return query
        .watch()
        .map((e) => e.map((e) => e.toToken(_tokenList)).toList());
  }

  Future<List<Token>> read() async {
    final query = _db.select(_db.favoriteTokenRows);

    return query
        .get()
        .then((e) => e.map((e) => e.toToken(_tokenList)).toList());
  }

  Stream<bool> isFavorite(Token token) {
    final query = _db.select(_db.favoriteTokenRows)
      ..where((p) => p.id.equals(token.extensions?.coingeckoId ?? token.name));

    return query.watchSingleOrNull().map((p) => p != null);
  }

  Future<void> clear() => _db.delete(_db.favoriteTokenRows).go();
}

class FavoriteTokenRows extends Table {
  const FavoriteTokenRows();

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get symbol => text()();
  TextColumn get logoUri => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

extension on Token {
  FavoriteTokenRow toDto() => FavoriteTokenRow(
        id: extensions?.coingeckoId ?? name,
        name: name,
        symbol: symbol,
        logoUri: logoURI,
      );
}

extension on FavoriteTokenRow {
  Token toToken(TokenList tokenList) {
    final id = this.id;
    final symbol = this.symbol.toLowerCase();

    if (symbol == Token.sol.symbol.toLowerCase()) return Token.sol;

    return tokenList.fromCoingecko(
      coingeckoId: id,
      symbol: symbol,
      name: name,
      image: logoUri,
    );
  }
}
