import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/tokens/token.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../data/db/db.dart';

@injectable
class PopularTokenCache {
  PopularTokenCache({
    required MyDatabase db,
    required TokenList tokenList,
  })  : _db = db,
        _tokenList = tokenList;

  final MyDatabase _db;
  final TokenList _tokenList;

  Future<IMap<Token, double>> get() =>
      _db.select(_db.popularTokenRows).get().then(
            (rows) =>
                IMap({for (var e in rows) e.toToken(_tokenList): e.price}),
          );

  Future<void> set(IMap<Token, double> result) => _db.transaction(() async {
        await _db.delete(_db.popularTokenRows).go();

        await _db.batch((batch) {
          batch.insertAll(
            _db.popularTokenRows,
            result.entries.map((e) => e.key.toDto(e.value)).toList(),
          );
        });
      });

  Future<void> remove() => _db.delete(_db.popularTokenRows).go();
}

class PopularTokenRows extends Table {
  const PopularTokenRows();

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get symbol => text()();
  TextColumn get logoUri => text().nullable()();
  RealColumn get price => real()();

  @override
  Set<Column<Object>> get primaryKey => {id};
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
