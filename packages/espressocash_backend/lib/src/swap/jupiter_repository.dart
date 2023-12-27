import 'package:collection/collection.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

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
    required Ed25519HDPublicKey platformReferralAddress,
  }) async {
    final quote = await _swapClient.getQuote(
      QuoteRequestDto(
        amount: int.parse(amount),
        inputMint: inputToken,
        outputMint: outputToken,
        slippageBps: slippageBps,
        swapMode: swapMode,
        onlyDirectRoutes: false,
        asLegacyTransaction: asLegacyTransaction,
        platformFeeBps: 100,
      ),
    );

    final bestRoute = quote.routePlan.firstOrNull;

    if (bestRoute == null) {
      throw Exception('No route found for given input and output');
    }

    final referralTokenAccount = await _calculateReferralAccount(
      referralPublicKey: platformReferralAddress,
      mintPublicKey: swapMode == SwapMode.exactIn
          ? Ed25519HDPublicKey.fromBase58(outputToken)
          : Ed25519HDPublicKey.fromBase58(inputToken),
    );

    final tx = await _swapClient
        .getSwapTransactions(
          JupiterSwapRequestDto(
            userPublicKey: account,
            quoteResponse: quote,
            asLegacyTransaction: asLegacyTransaction,
            wrapAndUnwrapSol: true,
            feeAccount: referralTokenAccount.toBase58(),
          ),
        )
        .then((jupiterTxs) => jupiterTxs.swapTransaction);

    return RouteInfo(
      amount: amount,
      inAmount: quote.inAmount,
      outAmount: quote.outAmount,
      jupiterTx: tx,
      totalFees: 0,
    );
  }

  Future<double?> getUsdcPrice() => _priceClient
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

Future<Ed25519HDPublicKey> _calculateReferralAccount({
  required Ed25519HDPublicKey referralPublicKey,
  required Ed25519HDPublicKey mintPublicKey,
}) =>
    Ed25519HDPublicKey.findProgramAddress(
      seeds: [
        'referral_ata'.codeUnits,
        referralPublicKey.bytes,
        mintPublicKey.bytes,
      ],
      programId: referralProgram,
    );

final referralProgram = Ed25519HDPublicKey.fromBase58(
  'REFER4ZgmyYx9c6He5XfaTMiGfdLwRnkV4RPp9t9iF3',
);
