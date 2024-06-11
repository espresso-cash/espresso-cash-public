import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../data/db/db.dart';

@singleton
class TokenListRepository {
  TokenListRepository(this._db);

  final MyDatabase _db;

  Future<List<TokenRow>> getAllTokens() async =>
      _db.select(_db.tokenRows).get();

  Stream<List<TokenRow>> watchAllTokens() => _db.select(_db.tokenRows).watch();

  Future<dynamic> insertToken(Insertable<TokenRow> token) =>
      _db.into(_db.tokenRows).insert(token);

  Future<dynamic> updateToken(Insertable<TokenRow> token) =>
      _db.update(_db.tokenRows).replace(token);

  Future<dynamic> deleteToken(Insertable<TokenRow> token) =>
      _db.delete(_db.tokenRows).delete(token);

  Future<dynamic> clearAllTokens() => _db.delete(_db.tokenRows).go();
}
