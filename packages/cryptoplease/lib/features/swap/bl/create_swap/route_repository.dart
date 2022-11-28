import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/tokens/token.dart';
import '../route.dart';

@injectable
class RouteRepository {
  RouteRepository({
    required JupiterAggregatorClient jupiterAggregatorClient,
    required CryptopleaseClient cryptopleaseClient,
  })  : _jupiterClient = jupiterAggregatorClient,
        _cpClient = cryptopleaseClient;

  final JupiterAggregatorClient _jupiterClient;
  final CryptopleaseClient _cpClient;

  Future<bool> routeExists(Token input, Token output) async {
    const dto = IndexedRouteMapRequestDto();
    final routeMap = await _jupiterClient.getIndexedRouteMap(dto);
    final mintKeys = routeMap.mintKeys;
    final outputIndex = mintKeys.indexOf(output.forJupiter.address);
    final inputIndex = mintKeys.indexOf(input.forJupiter.address).toString();

    return routeMap.indexedRouteMap[inputIndex]?.contains(outputIndex) ?? false;
  }

  Future<SwapRoute> findRoute({
    required CryptoAmount amount,
    required Token inputToken,
    required Token outputToken,
    required String userPublickKey,
    required Slippage slippage,
  }) async {
    final swapMode =
        amount.token == inputToken ? SwapMatch.inAmount : SwapMatch.outAmount;

    final route = await _cpClient.getSwapRoute(
      SwapRouteRequestDto(
        amount: amount.value.toString(),
        inputToken: inputToken.forJupiter.address,
        outputToken: outputToken.forJupiter.address,
        slippage: slippage.toDto(),
        match: swapMode,
        userAccount: userPublickKey,
      ),
    );

    return SwapRoute(
      amount: Decimal.parse(route.amount),
      inAmount: Decimal.parse(route.inAmount),
      outAmount: Decimal.parse(route.outAmount),
      fee: CryptoAmount(currency: Currency.usdc, value: route.feeInUsdc),
      encodedTx: route.encodedTx,
    );
  }
}

extension on Token {
  Token get forJupiter => this == Token.sol ? Token.wrappedSol : this;
}

extension on Slippage {
  SwapSlippage toDto() {
    switch (this) {
      case Slippage.zpOne:
        return SwapSlippage.zpOne;
      case Slippage.zpFive:
        return SwapSlippage.zpFive;
      case Slippage.onePercent:
        return SwapSlippage.onePercent;
    }
  }
}
