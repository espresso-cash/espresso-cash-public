import 'dart:core';

import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

Handler addSwapHandler() =>
    shelf_router.Router()..post('/createSwapTransaction', _handler);

Future<Response> _handler(Request request) async =>
    processRequest<SwapRequestDto, SwapResponseDto>(
      request,
      SwapRequestDto.fromJson,
      (data) async {
        final transactions = await _swapClient.getSwapTransactions(data);

        // TODO(rhbrunetto): change swap transaction to pay fees in USDC
        return SwapResponseDto(
          setupTransaction: transactions.setupTransaction,
          swapTransaction: transactions.swapTransaction,
          cleanupTransaction: transactions.cleanupTransaction,
        );
      },
    );

final _swapClient = JupiterAggregatorClient();
