import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/data/api/cp_client_extension.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/tx_processor.dart';
import 'package:cryptoplease/data/transaction/tx_creator.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dfunc/dfunc.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

class CpTxCreator implements TxCreator {
  CpTxCreator({
    required CryptopleaseClient cpClient,
    required SolanaClient solanaClient,
  })  : _cpClient = cpClient,
        _solanaClient = solanaClient;

  final CryptopleaseClient _cpClient;
  final SolanaClient _solanaClient;

  @override
  AsyncEither<TxCreationError, SignedTx> createOutgoingTx({
    required OutgoingTransfer payment,
    required MyAccount account,
  }) async {
    try {
      final recipient = await payment.getRecipient();
      final publicKey = recipient.toBase58();

      final createdPayment = await _cpClient.createPayment(
        CreatePaymentRequestDto(
          senderAccount: account.wallet.address,
          escrowAccount: publicKey,
          amount: payment.amount.toInt(),
          cluster: isProd ? Cluster.mainnet : Cluster.devnet,
        ),
      );
      final message = createdPayment.decompileMessage();
      final tx = await _solanaClient.rpcClient.signMessage(
        message,
        [account.wallet],
      );

      return Either.right(tx);
    } on Exception {
      return const Either.left(TxCreationError.other());
    }
  }

  @override
  AsyncEither<TxCreationError, SignedTx> createIncomingTx({
    required String firstPart,
    required String secondPart,
    required String recipient,
    required String tokenAddress,
  }) async {
    final Ed25519HDKeyPair escrow;

    try {
      escrow = await walletFromParts(
        firstPart: firstPart,
        secondPart: secondPart,
      );
    } on Object {
      return const Either.left(TxCreationError.invalidLink());
    }

    try {
      final request = ReceivePaymentRequestDto(
        receiverAccount: recipient,
        escrowAccount: escrow.address,
        cluster: isProd ? Cluster.mainnet : Cluster.devnet,
      );

      final payment = await _cpClient.receivePayment(request);
      final message = payment.decompileMessage();
      final tx = await _solanaClient.rpcClient.signMessage(
        message,
        [escrow],
      );

      return Either.right(tx);
    } on Exception {
      return const Either.left(TxCreationError.other());
    }
  }
}
