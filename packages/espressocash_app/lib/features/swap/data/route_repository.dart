import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../models/swap_route.dart';
import '../models/swap_seed.dart';

@injectable
class RouteRepository {
  const RouteRepository({
    required EspressoCashClient cryptopleaseClient,
  }) : _ecClient = cryptopleaseClient;

  final EspressoCashClient _ecClient;

  Future<SwapRoute> findRoute({
    required SwapSeed seed,
    required String userPublicKey,
  }) async {
    final swapMode = seed.amount.token == seed.inputToken
        ? SwapMatch.inAmount
        : SwapMatch.outAmount;

    final route = await _ecClient.getSwapRoute(
      SwapRouteRequestDto(
        amount: seed.amount.value.toString(),
        inputToken: seed.inputToken.forJupiter.address,
        outputToken: seed.outputToken.forJupiter.address,
        slippage: seed.slippage.toDto(),
        match: swapMode,
        userAccount: userPublicKey,
        asLegacyTx: false,
      ),
    );

    return SwapRoute(
      seed: seed,
      inAmount: int.parse(route.inAmount),
      outAmount: int.parse(route.outAmount),
      fee: CryptoAmount(cryptoCurrency: Currency.usdc, value: route.feeInUsdc),
      encodedTx: route.encodedTx,
      slot: route.slot,
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
