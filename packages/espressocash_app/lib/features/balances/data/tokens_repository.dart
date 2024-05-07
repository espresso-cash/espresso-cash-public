import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../accounts/auth_scope.dart';
import '../../currency/models/amount.dart';
import '../../tokens/token.dart';

@Singleton(scope: authScope)
class TokensRepository extends ChangeNotifier
    implements ValueListenable<Map<Token, CryptoAmount>> {
  TokensRepository();

  final _value = <Token, CryptoAmount>{};

  void save(Map<Token, CryptoAmount> tokens) {
    tokens
      ..removeWhere((token, amount) => amount.value == 0)
      ..remove(Token.usdc);

    _value.addAll(tokens);

    notifyListeners();
  }

  @override
  Map<Token, CryptoAmount> get value => _value;
}
