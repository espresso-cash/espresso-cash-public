import 'dart:core';

import 'package:collection/collection.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/constants.dart';
import 'package:cryptoplease_link/src/swap/create_swap.dart';
import 'package:cryptoplease_link/src/swap/jupiter_extension.dart';
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

        final futures = await Future.wait(
          [
            _swapClient.getQuote(
              QuoteRequestDto(
                amount: data.amount,
                inputMint: data.inputToken,
                outputMint: data.outputToken,
                slippageBps: data.slippage.toJupiterBps(),
                swapMode: data.match.toJupiterMode(),
                userPublicKey: account,
                enforceSingleTx: true,
              ),
            ),
            _priceClient.getPrice(
              const PriceRequestDto(id: 'SOL'),
            ),
          ],
        );
        final route = (futures.first as QuoteResponseDto).routes.firstOrNull;
        final price = (futures.last as PriceResponseDto).data.price;

        if (route == null) {
          throw Exception('No route found for given input and output');
        }

        final tx = await _swapClient
            .getSwapTransactions(
              JupiterSwapRequestDto(userPublicKey: account, route: route),
            )
            .then(
              (jupiterTxs) => [
                jupiterTxs.setupTransaction,
                jupiterTxs.swapTransaction,
                jupiterTxs.cleanupTransaction,
              ],
            )
            .then((txs) => txs.whereNotNull().singleOrNull);

        if (tx == null) {
          throw Exception('Swap only supports single transaction');
        }

        final fee = _calculateFee(route, price);

        final transaction = await createSwap(
          encodedTx: tx,
          aSender: Ed25519HDPublicKey.fromBase58(data.userAccount),
          platform: await _mainnetPlatform,
          client: _mainnetClient,
          commitment: Commitment.confirmed,
          feeAmount: fee,
        );

        return SwapRouteResponseDto(
          amount: route.amount,
          inAmount: route.inAmount,
          outAmount: route.outAmount,
          feeInUsdc: fee,
          encodedTx: transaction.encode(),
        );
      },
    );

int _calculateFee(JupiterRoute route, double price) {
  final feeInSol = route.fees?.totalFeeAndDeposits;

  if (feeInSol == null) {
    throw Exception('Route has no fee object');
  }

  return (feeInSol * price / solDecimals * usdcDecimals).round();
}

final _swapClient = JupiterAggregatorClient();
final _priceClient = JupiterPriceClient();
final _mainnetClient = SolanaClient(
  rpcUrl: Uri.parse(mainnetRpcUrl),
  websocketUrl: Uri.parse(mainnetWsUrl),
);
final _mainnetPlatform = Ed25519HDKeyPair.fromMnemonic(mainnetPlatformMnemonic);
