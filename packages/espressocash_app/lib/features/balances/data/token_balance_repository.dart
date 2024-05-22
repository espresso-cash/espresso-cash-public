import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/auth_scope.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../../tokens/token_list.dart';
import '../models/token_balance.dart';

@Singleton(scope: authScope)
class TokenBalancesRepository {
  TokenBalancesRepository(this._storage, this._tokens);

  final SharedPreferences _storage;
  final TokenList _tokens;

  final BehaviorSubject<IMap<Token, CryptoAmount>> _data =
      BehaviorSubject.seeded(const IMapConst({}));

  ISet<Token> readUserTokens() => {..._data.value.keys}.lock;

  CryptoAmount read(Token token) =>
      _data.value[token] ??
      CryptoAmount(value: 0, cryptoCurrency: CryptoCurrency(token: token));

  Stream<ISet<Token>> watchUserTokens() =>
      _data.map((data) => {...data.keys}.lock);

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

  @PostConstruct()
  void init() {
    final tokenBalances = _storage.getString(_tokensBalanceKey);

    if (tokenBalances == null) return;

    final List<dynamic> tokensJson =
        json.decode(tokenBalances) as List<dynamic>;

    final tokens = tokensJson.map((json) {
      final tokenBalance = TokenBalance.fromJson(json as Map<String, dynamic>);

      final token = _tokens.fromCoingeckoId(
        coingeckoId: tokenBalance.id,
        symbol: tokenBalance.symbol,
      );
      if (token == null) return null;

      return MapEntry(
        token,
        Amount.fromToken(value: tokenBalance.balance, token: token)
            as CryptoAmount,
      );
    }).whereNotNull();

    final value = Map<Token, CryptoAmount>.fromEntries(tokens);
    _data.add(value.lock);
  }

  void save(Map<Token, CryptoAmount> tokens) {
    tokens.clean();
    _data.add(tokens.lock);

    _storage.setString(_tokensBalanceKey, tokens.toJson());
  }

  @disposeMethod
  void dispose() {
    _storage.remove(_tokensBalanceKey);
  }
}

const _tokensBalanceKey = 'tokensBalance';

extension on Map<Token, CryptoAmount> {
  void clean() => removeWhere(
        (token, amount) =>
            amount.decimal <= Decimal.zero || token == Token.usdc,
      );

  String toJson() {
    final List<TokenBalance> tokensJson = entries
        .map(
          (entry) => TokenBalance(
            id: entry.key.coingeckoId ?? entry.key.name,
            symbol: entry.key.symbol,
            balance: entry.value.value,
          ),
        )
        .toList();

    return json.encode(tokensJson.map((e) => e.toJson()).toList());
  }
}
