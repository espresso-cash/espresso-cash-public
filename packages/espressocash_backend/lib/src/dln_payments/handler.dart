import 'dart:core';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:espressocash_backend/src/dln_payments/dln_repository.dart';
import 'package:espressocash_backend/src/dln_payments/payment.dart';
import 'package:espressocash_backend/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:solana/solana.dart';

Handler addDlnQuoteHandler() =>
    (shelf_router.Router()..post('/getDlnQuote', _dlnQuoteHandler)).call;

Future<Response?> _dlnQuoteHandler(Request request) =>
    processRequest<PaymentQuoteRequestDto, PaymentQuoteResponseDto>(
      request,
      PaymentQuoteRequestDto.fromJson,
      (data) async {
        final createPayment = DlnPayment(
          client: _mainnetClient,
          repository: DlnRepository(),
          platform: await _mainnetPlatform,
        );

        final tx = await createPayment(
          amount: data.amount,
          senderAddress: data.senderAddress,
          receiverAddress: data.receiverAddress,
          receiverChain: data.receiverBlockchain,
          commitment: Commitment.confirmed,
        );

        return PaymentQuoteResponseDto(
          inputAmount: data.amount,
          receiverAmount: tx.receiverAmount,
          feeInUsdc: tx.fee,
          slot: tx.slot,
          encodedTx: tx.transaction.encode(),
        );
      },
    );

final _mainnetClient = SolanaClient(
  rpcUrl: Uri.parse(mainnetRpcUrl),
  websocketUrl: Uri.parse(mainnetWsUrl),
);
final _mainnetPlatform = Ed25519HDKeyPair.fromMnemonic(
  mainnetPlatformMnemonic,
  account: 0,
  change: 0,
);
