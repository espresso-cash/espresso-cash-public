import 'dart:core';

import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/constants.dart';
import 'package:cryptoplease_link/src/swap/create_swap.dart';
import 'package:cryptoplease_link/src/swap/jupiter_repository.dart';
import 'package:cryptoplease_link/src/swap/price.dart';
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
        final reponses = await Future.wait([
          getJupiterRoute(
            amount: data.amount,
            inputToken: data.inputToken,
            outputToken: data.outputToken,
            slippageBps: data.slippage.toJupiterBps(),
            swapMode: data.match.toJupiterMode(),
            account: data.userAccount,
          ),
          getUsdcPrice(),
        ]);
        final route = reponses.first as RouteInfo;
        final price = reponses.last as double;

        final fee = convert(route.totalFees, price);

        final transaction = await createSwap(
          encodedTx: route.jupiterTx,
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

final _mainnetClient = SolanaClient(
  rpcUrl: Uri.parse(mainnetRpcUrl),
  websocketUrl: Uri.parse(mainnetWsUrl),
);
final _mainnetPlatform = Ed25519HDKeyPair.fromMnemonic(mainnetPlatformMnemonic);
