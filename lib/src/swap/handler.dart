import 'dart:core';

import 'package:collection/collection.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/constants.dart';
import 'package:cryptoplease_link/src/swap/create_swap.dart';
import 'package:cryptoplease_link/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:solana/solana.dart';

Handler addSwapHandler() =>
    shelf_router.Router()..post('/createSwapTransaction', _handler);

Future<Response> _handler(Request request) async =>
    processRequest<SwapRequestDto, SwapResponseDto>(
      request,
      SwapRequestDto.fromJson,
      (data) async {
        final transactions = await _swapClient.getSwapTransactions(data);

        final tx = [
          transactions.setupTransaction,
          transactions.swapTransaction,
          transactions.cleanupTransaction,
        ].whereNotNull().singleOrNull;

        if (tx == null) {
          throw Exception('Swap only supports single transaction');
        }

        final solFees = data.route.fees?.totalFeeAndDeposits.toInt();
        if (solFees == null) {
          throw Exception('Invalid route');
        }

        final swapWithFeePayer = await createSwap(
          encodedTx: tx,
          swapFees: solFees,
          aSender: Ed25519HDPublicKey.fromBase58(data.userPublicKey),
          platform: await _mainnetPlatform,
          client: _mainnetClient,
          commitment: Commitment.confirmed,
        );

        return SwapResponseDto(
          swapTransaction: swapWithFeePayer.encode(),
        );
      },
    );

final _swapClient = JupiterAggregatorClient();

final _mainnetClient = SolanaClient(
  rpcUrl: Uri.parse(mainnetRpcUrl),
  websocketUrl: Uri.parse(mainnetWsUrl),
);
final _mainnetPlatform = Ed25519HDKeyPair.fromMnemonic(mainnetPlatformMnemonic);
