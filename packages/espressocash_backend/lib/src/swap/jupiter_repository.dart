import 'package:collection/collection.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'jupiter_repository.freezed.dart';

@freezed
class RouteInfo with _$RouteInfo {
  const factory RouteInfo({
    required String amount,
    required String inAmount,
    required String outAmount,
    required String jupiterTx,
    required num totalFees,
  }) = _RouteInfo;
}

class JupiterRepository {
  final _swapClient = JupiterAggregatorClient();
  final _priceClient = JupiterPriceClient();

  final _sol = wrappedSol.toBase58();

  Future<RouteInfo> getJupiterRouteAndTransaction({
    required String amount,
    required String inputToken,
    required String outputToken,
    required int slippageBps,
    required SwapMode swapMode,
    required String account,
    required bool asLegacyTransaction,
  }) async {
    final quote = await _swapClient.getQuote(
      QuoteRequestDto(
        amount: amount,
        inputMint: inputToken,
        outputMint: outputToken,
        slippageBps: slippageBps,
        swapMode: swapMode,
        userPublicKey: account,
        onlyDirectRoutes: true,
        asLegacyTransaction: asLegacyTransaction,
      ),
    );

    final bestRoute = quote.routes.firstOrNull;

    if (bestRoute == null) {
      throw Exception('No route found for given input and output');
    }

    final feeInSol = bestRoute.fees?.totalFeeAndDeposits;

    if (feeInSol == null) {
      throw Exception('Route has no fee object');
    }

    final tx = await _swapClient
        .getSwapTransactions(
          JupiterSwapRequestDto(
            userPublicKey: account,
            route: bestRoute,
            asLegacyTransaction: asLegacyTransaction,
          ),
        )
        .then((jupiterTxs) => jupiterTxs.swapTransaction);

    return RouteInfo(
      amount: bestRoute.amount,
      inAmount: bestRoute.inAmount,
      outAmount: bestRoute.outAmount,
      jupiterTx: tx,
      totalFees: feeInSol,
    );
  }

  Future<double?> getUsdcPrice() async => _priceClient
      .getPrice(PriceRequestDto(ids: _sol))
      .then((response) => response.data[_sol]?.price);
}

extension SwapSlippageExt on SwapSlippage {
  int toJupiterBps() {
    double slippage;
    switch (this) {
      case SwapSlippage.zpOne:
        slippage = 0.1;
      case SwapSlippage.zpFive:
        slippage = 0.5;
      case SwapSlippage.onePercent:
        slippage = 1.0;
    }

    return slippage.ceil().toDouble().toInt() * 100;
  }
}

extension SwapMatchExt on SwapMatch {
  SwapMode toJupiterMode() {
    switch (this) {
      case SwapMatch.inAmount:
        return SwapMode.exactIn;
      case SwapMatch.outAmount:
        return SwapMode.exactOut;
    }
  }
}
