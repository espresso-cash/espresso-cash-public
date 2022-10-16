import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'tx_sender.freezed.dart';

@injectable
class TxSender {
  TxSender({
    required SolanaClient client,
  }) : _client = client;

  final SolanaClient _client;

  Future<TxSendResult> send(SignedTx tx) async {
    try {
      await _client.rpcClient.sendTransaction(
        tx.encode(),
        preflightCommitment: Commitment.confirmed,
      );

      return const TxSendResult.sent();
    } on JsonRpcException catch (e) {
      switch (e.transactionError) {
        case TransactionError.alreadyProcessed:
          return const TxSendResult.sent();
        case TransactionError.blockhashNotFound:
          return const TxSendResult.invalidBlockhash();
        default:
          return const TxSendResult.failure();
      }
    } on Exception {
      return const TxSendResult.networkError();
    }
  }

  Future<TxWaitResult> wait(String txId) async {
    try {
      await _client.waitForSignatureStatus(txId, status: Commitment.confirmed);

      return const TxWaitResult.success();
    } on SubscriptionClientException {
      return const TxWaitResult.failure();
    } on Exception {
      return const TxWaitResult.networkError();
    }
  }
}

@freezed
class TxSendResult with _$TxSendResult {
  const factory TxSendResult.sent() = TxSendSent;
  const factory TxSendResult.invalidBlockhash() = TxSendInvalidBlockhash;
  const factory TxSendResult.failure() = TxSendFailure;
  const factory TxSendResult.networkError() = TxSendNetworkError;
}

@freezed
class TxWaitResult with _$TxWaitResult {
  const factory TxWaitResult.success() = TxWaitSuccess;
  const factory TxWaitResult.failure() = TxWaitFailure;
  const factory TxWaitResult.networkError() = TxWaitNetworkError;
}
