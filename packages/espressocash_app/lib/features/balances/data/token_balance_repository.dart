import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/db/db.dart';
import '../../accounts/auth_scope.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../../tokens/token_list.dart';
import '../models/token_balance.dart';

@Singleton(scope: authScope)
class TokenBalancesRepository {
  TokenBalancesRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  final BehaviorSubject<IMap<Token, CryptoAmount>> _data =
      BehaviorSubject.seeded(const IMapConst({}));

  ISet<Token> readUserTokens() => {..._data.value.keys}.lock;

  CryptoAmount read(Token token) =>
      _data.value[token] ??
      CryptoAmount(value: 0, cryptoCurrency: CryptoCurrency(token: token));

  Stream<ISet<Token>> watchUserTokens() => _data.map((data) {
        final tokens = data.keys.where((token) => data[token]?.value != 0);

        return {...tokens}.lock;
      });

  (Stream<CryptoAmount>, CryptoAmount) watch(Token token) => (
        _data.map(
          (data) =>
              data[token] ??
              CryptoAmount(
                value: 0,
                cryptoCurrency: CryptoCurrency(token: token),
              ),
        ),
        read(token),
      );

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final tokenBalances = await _db.select(_db.tokenBalanceRows).get().then(
          (rows) => rows.map((row) => row.toModel()).toList(),
        );

    final tokens = tokenBalances.map((balance) {
      final token = _tokens.findTokenByMint(balance.address);
      if (token == null) return null;

      return MapEntry(
        token,
        Amount.fromToken(value: balance.balance, token: token) as CryptoAmount,
      );
    }).whereNotNull();

    final value = Map<Token, CryptoAmount>.fromEntries(tokens);
    _data.add(value.lock);
  }

  void save(Map<Token, CryptoAmount> tokens) {
    tokens.clean();
    _data.add(tokens.lock);

    _db.transaction(() async {
      await _db.delete(_db.tokenBalanceRows).go();
      await _db.batch(
        (batch) => batch.insertAll(
          _db.tokenBalanceRows,
          tokens.toList(),
          mode: InsertMode.insertOrReplace,
        ),
      );
    });
  }

  @disposeMethod
  void dispose() {
    _db.delete(_db.tokenBalanceRows).go();
  }
}

extension on Map<Token, CryptoAmount> {
  void clean() => removeWhere(
        (token, amount) => token == Token.usdc,
      );

  Iterable<TokenBalanceRow> toList() => entries.map(
        (entry) => TokenBalance(
          address: entry.key.address,
          balance: entry.value.value,
        ).toDto(),
      );
}

extension on TokenBalanceRow {
  TokenBalance toModel() => TokenBalance(
        address: token,
        balance: amount,
      );
}

extension on TokenBalance {
  TokenBalanceRow toDto() => TokenBalanceRow(
        token: address,
        amount: balance,
      );
}
