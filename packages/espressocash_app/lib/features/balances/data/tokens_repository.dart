import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/auth_scope.dart';
import '../../currency/models/amount.dart';
import '../../tokens/token.dart';
import '../../tokens/token_list.dart';
import '../models/token_balance.dart';

@Singleton(scope: authScope)
class TokensRepository extends ChangeNotifier
    implements ValueListenable<Map<Token, CryptoAmount>> {
  TokensRepository(this._storage, this._tokens);

  final SharedPreferences _storage;
  final TokenList _tokens;

  Map<Token, CryptoAmount> _value = <Token, CryptoAmount>{};

  @override
  Map<Token, CryptoAmount> get value => _value;

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

    _value = Map<Token, CryptoAmount>.fromEntries(tokens);

    notifyListeners();
  }

  void save(Map<Token, CryptoAmount> tokens) {
    tokens.clean();
    _value = tokens;

    notifyListeners();

    _storage.setString(_tokensBalanceKey, tokens.toJson());
  }
}

const _tokensBalanceKey = 'tokensBalance';

extension on Map<Token, CryptoAmount> {
  void clean() =>
      removeWhere((token, amount) => amount.value == 0 || token == Token.usdc);

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
