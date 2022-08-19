import 'package:collection/collection.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/data/api/cp_client_extension.dart';
import 'package:cryptoplease/data/transaction/tx_processor.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/bloc.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dfunc/dfunc.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

class CpTxProcessor implements TxProcessor {
  CpTxProcessor(
    this._cpClient,
    this._solanaClient,
  );

  final CryptopleaseClient _cpClient;
  final SolanaClient _solanaClient;

  @override
  AsyncEither<TxCreationError, SignedTx> createTx({
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

      final signed =
          await _solanaClient.rpcClient.signMessage(message, [escrow]);

      return Either.right(signed);
    } on Exception {
      return const Either.left(TxCreationError.other());
    }
  }

  @override
  AsyncEither<SplitKeyIncomingPaymentError, SignedTx> sendPayment(
    SignedTx tx,
  ) async {
    try {
      await _solanaClient.rpcClient.sendTransaction(
        tx.encode(),
        preflightCommitment: Commitment.confirmed,
      );

      return Either.right(tx);
    } on JsonRpcException catch (e) {
      final txError = e.transactionError;

      switch (txError) {
        case TransactionError.alreadyProcessed:
          return Either.right(tx);
        case TransactionError.blockhashNotFound:
          return _solanaClient.rpcClient
              .getTransaction(tx.id)
              .toEither()
              .foldAsync(
                always(
                  const Either.left(SplitKeyIncomingPaymentError.invalidTx()),
                ),
                always(Either.right(tx)),
              );
        default:
          return const Either.left(SplitKeyIncomingPaymentError.invalidTx());
      }
    } on Exception {
      return Either.left(SplitKeyIncomingPaymentError.failedToSubmit(tx));
    }
  }

  @override
  AsyncEither<SplitKeyIncomingPaymentError, SignedTx> wait(SignedTx tx) async {
    try {
      await _solanaClient.waitForSignatureStatus(
        tx.id,
        status: Commitment.confirmed,
        timeout: waitForSignatureDefaultTimeout,
      );

      return Either.right(tx);
    } on Object {
      return Either.left(SplitKeyIncomingPaymentError.failedToConfirm(tx));
    }
  }
}

Future<Wallet> walletFromParts({
  required String firstPart,
  required String secondPart,
}) async {
  final keyPart1 = ByteArray.fromBase58(firstPart).toList();
  final keyPart2 = ByteArray.fromBase58(secondPart).toList();

  return Wallet.fromPrivateKeyBytes(privateKey: keyPart1 + keyPart2);
}

extension on Transaction {
  String? transferDestinationOrNull() {
    final tx = this;
    if (tx is! ParsedTransaction) return null;

    final parsed = tx.message.instructions.whereType<ParsedInstruction>();

    return parsed
            .map((i) => i.mapOrNull(system: (i) => i.parsed))
            .whereNotNull()
            .map(
              (i) => i.mapOrNull(
                transfer: (i) => i.info.destination,
                transferChecked: (i) => i.info.destination,
              ),
            )
            .whereNotNull()
            .firstOrNull ??
        parsed
            .map((i) => i.mapOrNull(splToken: (i) => i.parsed))
            .whereNotNull()
            .map(
              (i) => i.mapOrNull(
                transfer: (i) => i.info.destination,
                transferChecked: (i) => i.info.destination,
              ),
            )
            .whereNotNull()
            .firstOrNull;
  }
}
