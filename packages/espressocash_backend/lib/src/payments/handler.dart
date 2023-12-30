import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:espressocash_backend/src/payments/create_direct_payment.dart';
import 'package:espressocash_backend/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:solana/solana.dart';

Handler paymentHandler() => (shelf_router.Router()
      ..post('/createDirectPayment', createDirectPaymentHandler)
      ..post('/getFees', getFeesHandler))
    .call;

Future<Response> getFeesHandler(Request request) =>
    processRequest<void, GetFeesResponseDto>(
      request,
      ignore,
      (_) async => const GetFeesResponseDto(
        directPayment: DirectPaymentFeeDto(
          ataExists: directPaymentFee,
          ataDoesNotExist: directPaymentWithAccountCreationFee,
        ),
        escrowPayment: escrowPaymentFee,
        escrowPaymentAtaFee: escrowPaymentAccountCreationFee,
        splitKeyPayment: 0,
      ),
    );

Future<Response> createDirectPaymentHandler(Request request) => processRequest<
        CreateDirectPaymentRequestDto, CreateDirectPaymentResponseDto>(
      request,
      CreateDirectPaymentRequestDto.fromJson,
      (data) async {
        final cluster = data.cluster;

        final payment = await createDirectPayment(
          aSender: Ed25519HDPublicKey.fromBase58(data.senderAccount),
          aReceiver: Ed25519HDPublicKey.fromBase58(data.receiverAccount),
          aReference: data.referenceAccount?.let(Ed25519HDPublicKey.fromBase58),
          mint: cluster.mint,
          amount: data.amount,
          platform: await cluster.platformAccount,
          client: cluster.solanaClient,
          commitment: Commitment.confirmed,
        );

        return CreateDirectPaymentResponseDto(
          fee: payment.fee,
          transaction: payment.transaction.encode(),
          slot: payment.slot,
        );
      },
    );

final _devnetClient = SolanaClient(
  rpcUrl: Uri.parse('https://api.devnet.solana.com'),
  websocketUrl: Uri.parse('wss://api.devnet.solana.com'),
);
final _devnetPlatform = Ed25519HDKeyPair.fromMnemonic(
  devnetPlatformMnemonic,
  account: 0,
  change: 0,
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
