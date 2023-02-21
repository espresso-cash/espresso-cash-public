import 'dart:core';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:espressocash_backend/src/swap/create_swap.dart';
import 'package:espressocash_backend/src/swap/jupiter_repository.dart';
import 'package:espressocash_backend/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:solana/solana.dart';

Handler addSwapHandler() =>
    (shelf_router.Router()..post('/getSwapRoute', _swapRouteHandler)).call;

Future<Response> _swapRouteHandler(Request request) async =>
    processRequest<SwapRouteRequestDto, SwapRouteResponseDto>(
      request,
      SwapRouteRequestDto.fromJson,
      (data) async {
        final createSwap = CreateSwap(
          client: _mainnetClient,
          repository: JupiterRepository(),
          platform: await _mainnetPlatform,
        );

        final tx = await createSwap(
          aSender: Ed25519HDPublicKey.fromBase58(data.userAccount),
          commitment: Commitment.confirmed,
          amount: data.amount,
          inputToken: data.inputToken,
          outputToken: data.outputToken,
          mode: data.match.toJupiterMode(),
          slippage: data.slippage.toJupiterBps(),
          asLegacyTx: data.asLegacyTx,
        );

        return SwapRouteResponseDto(
          amount: tx.amount,
          inAmount: tx.inAmount,
          outAmount: tx.outAmount,
          feeInUsdc: tx.fee,
          encodedTx: tx.transaction.encode(),
          slot: tx.slot,
        );
      },
    );

final _mainnetClient = SolanaClient(
  rpcUrl: Uri.parse(mainnetRpcUrl),
  websocketUrl: Uri.parse(mainnetWsUrl),
);
final _mainnetPlatform = Ed25519HDKeyPair.fromMnemonic(mainnetPlatformMnemonic);
