import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/bloc.dart';
import 'package:dfunc/dfunc.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

class TxProcessor {
  TxProcessor(this._solanaClient);

  final SolanaClient _solanaClient;

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
