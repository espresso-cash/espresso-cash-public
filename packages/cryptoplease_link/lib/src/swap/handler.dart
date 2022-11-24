import 'dart:core';

import 'package:collection/collection.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/constants.dart';
import 'package:cryptoplease_link/src/swap/amount_converter.dart';
import 'package:cryptoplease_link/src/swap/create_swap.dart';
import 'package:cryptoplease_link/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:solana/solana.dart';

Handler addSwapHandler() =>
    shelf_router.Router()..post('/getSwapRoute', _swapRouteHandler);

Future<Response> _swapRouteHandler(Request request) async =>
    processRequest<SwapRouteRequestDto, SwapRouteResponseDto>(
      request,
      SwapRouteRequestDto.fromJson,
      (data) async {
        final account = data.userAccount;

        final quote = await _swapClient.getQuote(
          QuoteRequestDto(
            amount: data.amount,
            inputMint: data.inputToken,
            outputMint: data.outputToken,
            slippageBps: data.slippage.toBps(),
            swapMode: data.match.toMode(),
            userPublicKey: account,
            enforceSingleTx: true,
          ),
        );

        final bestRoute = quote.routes.firstOrNull;

        if (bestRoute == null) {
          throw Exception('No route found for given input and output');
        }

        final jupiterTxs = await _swapClient.getSwapTransactions(
          SwapRequestDto(
            userPublicKey: account,
            route: bestRoute,
          ),
        );

        final tx = [
          jupiterTxs.setupTransaction,
          jupiterTxs.swapTransaction,
          jupiterTxs.cleanupTransaction,
        ].whereNotNull().singleOrNull;

        if (tx == null) {
          throw Exception('Swap only supports single transaction');
        }

        final fee = await extractFee(bestRoute);

        final transaction = await createSwap(
          encodedTx: tx,
          aSender: Ed25519HDPublicKey.fromBase58(data.userAccount),
          platform: await _mainnetPlatform,
          client: _mainnetClient,
          commitment: Commitment.confirmed,
          feeAmount: fee,
        );

        return SwapRouteResponseDto(
          amount: bestRoute.amount,
          inAmount: bestRoute.inAmount,
          outAmount: bestRoute.outAmount,
          feeInUsdc: fee,
          encodedTx: transaction.encode(),
        );
      },
    );

extension on SwapSlippage {
  int toBps() {
    double slippage;
    switch (this) {
      case SwapSlippage.zpOne:
        slippage = 0.1;
        break;
      case SwapSlippage.zpFive:
        slippage = 0.5;
        break;
      case SwapSlippage.onePercent:
        slippage = 1.0;
        break;
    }

    return slippage.ceil().toDouble().toInt() * 100;
  }
}

extension on SwapMatch {
  SwapMode toMode() {
    switch (this) {
      case SwapMatch.inAmount:
        return SwapMode.exactIn;
      case SwapMatch.outAmount:
        return SwapMode.exactOut;
    }
  }
}

final _swapClient = JupiterAggregatorClient();

final _mainnetClient = SolanaClient(
  rpcUrl: Uri.parse(mainnetRpcUrl),
  websocketUrl: Uri.parse(mainnetWsUrl),
);
final _mainnetPlatform = Ed25519HDKeyPair.fromMnemonic(mainnetPlatformMnemonic);
