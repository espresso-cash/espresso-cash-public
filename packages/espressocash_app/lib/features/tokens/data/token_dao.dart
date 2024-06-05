import 'package:drift/drift.dart';
import '../../../data/db/db.dart';

part 'token_dao.g.dart';

@DriftAccessor(tables: [TokenRows])
class TokenDao extends DatabaseAccessor<MyDatabase> with _$TokenDaoMixin {
  TokenDao(this.db) : super(db);

  final MyDatabase db;

  Future<List<TokenRow>> getAllTokens() => select(tokenRows).get();

  Stream<List<TokenRow>> watchAllTokens() => select(tokenRows).watch();

  Future<dynamic> insertToken(Insertable<TokenRow> token) =>
      into(tokenRows).insert(token);

  Future<dynamic> updateToken(Insertable<TokenRow> token) =>
      update(tokenRows).replace(token);

  Future<dynamic> deleteToken(Insertable<TokenRow> token) =>
      delete(tokenRows).delete(token);

  Future<dynamic> clearAllTokens() => delete(tokenRows).go();
}
