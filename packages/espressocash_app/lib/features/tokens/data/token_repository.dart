import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/db/db.dart';
import '../token.dart';

@singleton
class TokenListRepository {
  const TokenListRepository(this._db);

  final MyDatabase _db;

  Future<Token> getToken(String address) {
    final query = _db.select(_db.tokenRows)
      ..where((token) => token.address.equals(address));

    return query.getSingle().letAsync(
          (row) => _db.tokenRows.toModel(row),
        );
  }

  Future<dynamic> insertToken(Insertable<TokenRow> token) =>
      _db.into(_db.tokenRows).insert(token);

  Future<dynamic> updateToken(Insertable<TokenRow> token) =>
      _db.update(_db.tokenRows).replace(token);

  Future<dynamic> deleteToken(Insertable<TokenRow> token) =>
      _db.delete(_db.tokenRows).delete(token);

  Future<dynamic> clearAllTokens() => _db.delete(_db.tokenRows).go();
}

extension TokenRowsExt on TokenRows {
  Token toModel(TokenRow token) => Token(
        address: token.address,
        name: token.name,
        symbol: token.symbol,
        decimals: token.decimals,
        logoURI: token.logoURI,
        chainId: token.chainId,
        tags: token.tags,
        extensions: token.extensions,
      );
}
