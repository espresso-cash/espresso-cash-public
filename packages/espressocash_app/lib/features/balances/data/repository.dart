import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../data/db/db.dart';
import '../../accounts/auth_scope.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../../tokens/token_list.dart';

@Singleton(scope: authScope)
class TokenBalancesRepository {
  const TokenBalancesRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<CryptoAmount> read(Token token) async {
    final query = _db.tokenBalanceRows.select()
      ..where((tbl) => tbl.token.equals(token.address));

    final row = await query.getSingleOrNull();

    return row == null
        ? CryptoAmount(value: 0, cryptoCurrency: CryptoCurrency(token: token))
        : CryptoAmount(
            value: row.amount,
            cryptoCurrency: CryptoCurrency(token: token),
          );
  }

  Future<ISet<Token>> readUserTokens() {
    final query = _db.tokenBalanceRows.select()
      ..where((tbl) => tbl.amount.isBiggerThanValue(0));

    return query.get().then(
          (rows) => rows
              .map((row) => _tokens.findTokenByMint(row.token))
              .whereNotNull()
              .toISet(),
        );
  }

  Stream<ISet<Token>> watchUserTokens({
    Iterable<Token> ignoreTokens = const [],
  }) {
    final query = _db.tokenBalanceRows.select()
      ..where(
        (tbl) =>
            tbl.amount.isBiggerThanValue(0) &
            tbl.token.isNotIn(ignoreTokens.map((e) => e.address).toList()),
      );

    return query.watch().map(
          (rows) => rows
              .map((row) => _tokens.findTokenByMint(row.token))
              .whereNotNull()
              .toISet(),
        );
  }

  Stream<IList<CryptoAmount>> watchTokenBalances({
    Iterable<Token> ignoreTokens = const [],
  }) {
    final query = _db.tokenBalanceRows.select()
      ..where(
        (tbl) =>
            tbl.amount.isBiggerThanValue(0) &
            tbl.token.isNotIn(ignoreTokens.map((e) => e.address).toList()),
      );

    return query.watch().map(
          (rows) => rows
              .map((row) {
                final token = _tokens.findTokenByMint(row.token);

                if (ignoreTokens.contains(token)) {
                  return null;
                }

                return token == null
                    ? null
                    : CryptoAmount(
                        value: row.amount,
                        cryptoCurrency: CryptoCurrency(token: token),
                      );
              })
              .whereNotNull()
              .sortedBy((element) => element.token.name)
              .toIList(),
        );
  }

  Stream<CryptoAmount> watch(Token token) {
    final query = _db.tokenBalanceRows.select()
      ..where((tbl) => tbl.token.equals(token.address));
    final currency = CryptoCurrency(token: token);

    return query.watchSingleOrNull().map(
          (row) => row == null
              ? CryptoAmount(value: 0, cryptoCurrency: currency)
              : CryptoAmount(value: row.amount, cryptoCurrency: currency),
        );
  }

  Future<void> save(Iterable<CryptoAmount> balances) =>
      _db.transaction(() async {
        await _db.delete(_db.tokenBalanceRows).go();
        await _db.batch(
          (batch) => batch.insertAll(
            _db.tokenBalanceRows,
            balances.map(
              (e) => TokenBalanceRow(amount: e.value, token: e.token.address),
            ),
            mode: InsertMode.insertOrReplace,
          ),
        );
      });

  @disposeMethod
  void dispose() {
    _db.delete(_db.tokenBalanceRows).go();
  }
}
