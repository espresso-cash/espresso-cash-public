import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../config.dart';
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

  Future<List<Token>> fetch() async {
    final query = _db.select(_db.favoriteTokenRows);

    return query
        .get()
        .then((e) => e.map((e) => e.toToken(_tokenList)).toList());
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
  Token toToken(TokenList tokenList) {
    final id = this.id;
    final symbol = this.symbol.toLowerCase();

    if (symbol == Token.sol.symbol.toLowerCase()) return Token.sol;

    return tokenList.tokens
        .singleWhereOrNull(
          (t) => t.symbol.toLowerCase() == symbol && t.coingeckoId == id,
        )
        .ifNull(_createStubToken);
  }

  Token _createStubToken() => Token(
        chainId: currentChainId,
        address: id,
        symbol: symbol.toUpperCase(),
        name: name,
        decimals: 0,
        logoURI: logoUri,
        tags: const [],
        extensions: Extensions(coingeckoId: id),
      );
}
