import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token.dart';
import '../../authenticated/auth_scope.dart';

@Singleton(scope: authScope)
class BalancesRepository implements Disposable {
  final BehaviorSubject<IMap<Token, CryptoAmount>> _data =
      BehaviorSubject.seeded(const IMapConst({}));

  void saveAll(IMap<Token, CryptoAmount> data) {
    _data.add(data);
  }

  IMap<Token, CryptoAmount> readAll() => _data.value;

  CryptoAmount read(Token token) =>
      _data.value[token] ??
      CryptoAmount(value: 0, cryptoCurrency: CryptoCurrency(token: token));

  ValueStream<CryptoAmount> watch(Token token) => _data
      .map(
        (data) =>
            data[token] ??
            CryptoAmount(
              value: 0,
              cryptoCurrency: CryptoCurrency(token: token),
            ),
      )
      .shareValue();

  ValueStream<ISet<Token>> watchUserTokens() => _data
      .map((data) => {...data.keys, Token.sol, Token.usdc}.lock)
      .shareValue();

  ISet<Token> readUserTokens() =>
      {..._data.value.keys, Token.sol, Token.usdc}.lock;

  @override
  void onDispose() => _data.add(const IMapConst({}));
}
