import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/currency.dart';
import '../../../../../core/tokens/token.dart';
import '../swap_route.dart';

@injectable
class RouteRepository {
  RouteRepository({
    required CryptopleaseClient cryptopleaseClient,
  }) : _cpClient = cryptopleaseClient;

  final CryptopleaseClient _cpClient;

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
      inAmount: int.parse(route.inAmount),
      outAmount: int.parse(route.outAmount),
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
