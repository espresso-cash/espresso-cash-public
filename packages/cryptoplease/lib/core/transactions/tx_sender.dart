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
      if (e.isInsufficientFunds) {
        return const TxSendResult.failure(
          reason: TxFailureReason.insufficientFunds,
        );
      }
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
  const factory TxSendResult.failure({TxFailureReason? reason}) = TxSendFailure;
  const factory TxSendResult.networkError() = TxSendNetworkError;
}

@freezed
class TxWaitResult with _$TxWaitResult {
  const factory TxWaitResult.success() = TxWaitSuccess;
  const factory TxWaitResult.failure() = TxWaitFailure;
  const factory TxWaitResult.networkError() = TxWaitNetworkError;
}

enum TxFailureReason { insufficientFunds }

extension on JsonRpcException {
  // TODO(KB): Think about some better error handling
  bool get isInsufficientFunds {
    final data = this.data;
    if (data is! Map<String, dynamic>) return false;

    final error = data['err'];
    if (error is! Map<String, dynamic>) return false;

    final instructionError = error['InstructionError'];
    if (instructionError is! List<dynamic>) return false;
    if (instructionError.length < 2) return false;

    final instructionErrorData = instructionError[1];
    if (instructionErrorData is! Map<String, dynamic>) return false;

    return instructionErrorData['Custom'] == 1;
  }
}
