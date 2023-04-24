import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:espressocash_backend/src/escrow_payments/cancel_payment.dart';
import 'package:espressocash_backend/src/escrow_payments/create_payment.dart';
import 'package:espressocash_backend/src/escrow_payments/receive_payment.dart';
import 'package:espressocash_backend/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:solana/solana.dart';

Handler escrowPaymentsHandler() => (shelf_router.Router()
      ..post('/escrow/create', createPaymentHandler)
      ..post('/escrow/receive', receivePaymentHandler)
      ..post('/escrow/cancel', cancelPaymentHandler))
    .call;

Future<Response> createPaymentHandler(Request request) async =>
    processRequest<CreatePaymentRequestDto, CreatePaymentResponseDto>(
      request,
      CreatePaymentRequestDto.fromJson,
      (data) async {
        final cluster = data.cluster;

        final result = await createPaymentTx(
          aSender: Ed25519HDPublicKey.fromBase58(data.senderAccount),
          aEscrow: Ed25519HDPublicKey.fromBase58(data.escrowAccount),
          mint: cluster.mint,
          amount: data.amount,
          platform: await cluster.platformAccount,
          client: cluster.solanaClient,
          commitment: Commitment.confirmed,
        );

        return CreatePaymentResponseDto(
          transaction: result.item1.encode(),
          slot: result.item2,
        );
      },
    );

Future<Response> receivePaymentHandler(Request request) async =>
    processRequest<ReceivePaymentRequestDto, ReceivePaymentResponseDto>(
      request,
      ReceivePaymentRequestDto.fromJson,
      (data) async {
        final cluster = data.cluster;

        final result = await receivePaymentTx(
          aReceiver: Ed25519HDPublicKey.fromBase58(data.receiverAccount),
          aEscrow: Ed25519HDPublicKey.fromBase58(data.escrowAccount),
          mint: cluster.mint,
          platform: await cluster.platformAccount,
          client: cluster.solanaClient,
          commitment: Commitment.confirmed,
        );

        return ReceivePaymentResponseDto(
          transaction: result.item1.encode(),
          slot: result.item2,
        );
      },
    );

Future<Response> cancelPaymentHandler(Request request) async =>
    processRequest<CancelPaymentRequestDto, CancelPaymentResponseDto>(
      request,
      CancelPaymentRequestDto.fromJson,
      (data) async {
        final cluster = data.cluster;

        final result = await cancelPaymentTx(
          aSender: Ed25519HDPublicKey.fromBase58(data.senderAccount),
          aEscrow: Ed25519HDPublicKey.fromBase58(data.escrowAccount),
          mint: cluster.mint,
          platform: await cluster.platformAccount,
          client: cluster.solanaClient,
          commitment: Commitment.confirmed,
        );

        return CancelPaymentResponseDto(
          transaction: result.item1.encode(),
          slot: result.item2,
        );
      },
    );

final _devnetClient = SolanaClient(
  rpcUrl: Uri.parse('https://api.devnet.solana.com'),
  websocketUrl: Uri.parse('wss://api.devnet.solana.com'),
);
final _devnetPlatform = Ed25519HDKeyPair.fromMnemonic(devnetPlatformMnemonic);

final _mainnetClient = SolanaClient(
  rpcUrl: Uri.parse(mainnetRpcUrl),
  websocketUrl: Uri.parse(mainnetWsUrl),
);
final _mainnetPlatform = Ed25519HDKeyPair.fromMnemonic(mainnetPlatformMnemonic);

extension on Cluster {
  SolanaClient get solanaClient {
    switch (this) {
      case Cluster.mainnet:
        return _mainnetClient;
      case Cluster.devnet:
        return _devnetClient;
    }
  }

  Future<Ed25519HDKeyPair> get platformAccount {
    switch (this) {
      case Cluster.mainnet:
        return _mainnetPlatform;
      case Cluster.devnet:
        return _devnetPlatform;
    }
  }

  Ed25519HDPublicKey get mint {
    switch (this) {
      case Cluster.mainnet:
        return mainnetUsdc;
      case Cluster.devnet:
        return devnetUsdc;
    }
  }
}
