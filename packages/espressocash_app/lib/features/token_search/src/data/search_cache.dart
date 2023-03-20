import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/tokens/token.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';

const _maxAge = Duration(hours: 1);

@injectable
class SearchCache {
  SearchCache({
    required MyDatabase db,
  }) : _db = db;

  final MyDatabase _db;

  Future<List<Token>?> get(String term, {required TokenList tokenList}) async {
    final now = DateTime.now();
    final query = _db.select(_db.tokenSearchCacheRows)
      ..where((p) => p.query.equals(term))
      ..where(
        (p) => p.created.isBiggerOrEqualValue(
          now.subtract(_maxAge),
        ),
      );

    return query
        .get()
        .then((row) => row.map((e) => e.toModel(tokenList)).toList());
  }

  Future<void> set(String term, IList<Token> result) => _db.batch(
        (batch) {
          batch
            ..deleteWhere(
              _db.tokenSearchCacheRows,
              (t) => t.query.equals(term),
            )
            ..insertAll(
              _db.tokenSearchCacheRows,
              result.map((e) => e.toRow(term)),
            );
        },
      );
  Future<void> remove(String term) =>
      (_db.delete(_db.tokenSearchCacheRows)..where((t) => t.query.equals(term)))
          .go();

  Future<void> clear() => _db.delete(_db.tokenSearchCacheRows).go();
}

class TokenSearchCacheRows extends Table with QueryMixin {
  TextColumn get coingeckoId => text()();
  TextColumn get name => text()();
  TextColumn get symbol => text()();
  TextColumn get image => text().nullable()();
}

extension on Token {
  TokenSearchCacheRowsCompanion toRow(String term) =>
      TokenSearchCacheRowsCompanion.insert(
        query: term,
        created: DateTime.now(),
        coingeckoId: extensions?.coingeckoId ?? name,
        name: name,
        symbol: symbol,
        image: Value(logoURI),
      );
}

extension on TokenSearchCacheRow {
  Token toModel(TokenList tokenList) {
    if (symbol == Token.sol.symbol.toLowerCase()) return Token.sol;

    return tokenList.fromCoingecko(
      coingeckoId: coingeckoId,
      name: name,
      symbol: symbol,
      image: image,
    );
  }
}
