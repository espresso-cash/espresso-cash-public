import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../config.dart';
import '../models/tx_results.dart';

@injectable
class TxSender {
  TxSender({
    required SolanaClient client,
  }) : _client = client;

  final SolanaClient _client;

  Future<TxSendResult> send(
    SignedTx tx, {
    required BigInt minContextSlot,
  }) async {
    Future<TxSendResult> checkSubmittedTx(String txId) => _client.rpcClient
            .getSignatureStatuses([txId], searchTransactionHistory: true).then(
          (statuses) => statuses.value.first == null
              ? (statuses.context.slot >= minContextSlot
                  ? const TxSendResult.invalidBlockhash()
                  : const TxSendResult.networkError())
              : const TxSendResult.sent(),
          onError: (_) => const TxSendResult.networkError(),
        );

    try {
      await _client.rpcClient.sendTransaction(
        tx.encode(),
        preflightCommitment: Commitment.confirmed,
        minContextSlot: minContextSlot.toInt(),
      );

      return const TxSendResult.sent();
    } on JsonRpcException catch (error) {
      if (error.code == JsonRpcErrorCode.minContextSlotNotReached) {
        return const TxSendResult.networkError();
      }

      if (error.isInsufficientFunds) {
        return const TxSendResult.failure(
          reason: TxFailureReason.insufficientFunds,
        );
      }
      switch (error.transactionError) {
        case TransactionError.alreadyProcessed:
          return const TxSendResult.sent();
        case TransactionError.blockhashNotFound:
          return checkSubmittedTx(tx.id);
        // ignore: no_default_cases, not interested in other options
        default:
          return const TxSendResult.failure(reason: TxFailureReason.txError);
      }
    } on Exception {
      return const TxSendResult.networkError();
    }
  }

  Future<TxWaitResult> wait(
    SignedTx tx, {
    required BigInt minContextSlot,
  }) {
    const commitment = Commitment.confirmed;
    final start = DateTime.now();

    Future<TxWaitResult?> getSignatureStatus() async {
      // We need to check blockhash validity before searching for tx to make
      // sure that it's valid for the tx response slot.
      // ignore: move-variable-closer-to-its-usage
      final blockhashValidity = await _client.rpcClient.isBlockhashValid(
        tx.blockhash,
        commitment: commitment,
        minContextSlot: minContextSlot.toInt(),
      );

      final statuses = await _client.rpcClient.getSignatureStatuses(
        [tx.id],
        searchTransactionHistory: true,
      );
      final t = statuses.value.first;

      if (t == null) {
        // Blockhash is still valid, tx can be submitted.
        if (blockhashValidity.value) return null;

        if (DateTime.now().difference(start).inSeconds > 90) {
          // We've been waiting for too long, blockhash is invalid and it
          // won't be valid.
          return const TxWaitResult.failure(
            reason: TxFailureReason.invalidBlockhashWaiting,
          );
        }

        // No minContextSlot, it's not safe to assume that we get the latest
        // status.
        if (minContextSlot == BigInt.zero) return null;

        // We were calling the status with too old slot, we cannot be sure
        // that tx was not submitted.
        if (statuses.context.slot < minContextSlot) return null;

        // We were calling the status with too old slot, blockhash validity
        // is not guaranteed.
        if (statuses.context.slot < blockhashValidity.context.slot) return null;

        // At this stage, blockhash is invalid and it won't be valid, so
        // tx cannot be submitted.
        return const TxWaitResult.failure(
          reason: TxFailureReason.invalidBlockhashWaiting,
        );
      }

      if (t.err != null) {
        return const TxWaitResult.failure(reason: TxFailureReason.txError);
      }

      if (t.confirmationStatus.index >= ConfirmationStatus.confirmed.index) {
        return const TxWaitResult.success();
      }
    }

    Future<TxWaitResult> waitForSignatureStatus() async {
      try {
        await _client.waitForSignatureStatus(
          tx.id,
          status: commitment,
          pingInterval: pingDefaultInterval,
          timeout: waitForSignatureDefaultTimeout,
        );

        return const TxWaitResult.success();
      } on SubscriptionClientException {
        return const TxWaitResult.failure(reason: TxFailureReason.txError);
      } on Exception {
        return const TxWaitResult.networkError();
      }
    }

    final polling = _createPolling<TxWaitResult?>(
      createSource: () => getSignatureStatus().asStream(),
    );

    return Future.any([
      polling.whereNotNull().first,
      waitForSignatureStatus(),
    ]);
  }
}

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

Stream<T> _createPolling<T>({required Func0<Stream<T>> createSource}) {
  Duration backoff = const Duration(seconds: 1);

  Stream<void> retryWhen(void _, void __) async* {
    await Future<void>.delayed(backoff);
    if (backoff < const Duration(seconds: 30)) backoff *= 2;

    yield null;
  }

  return RetryWhenStream(
    () => Stream<void>.periodic(const Duration(seconds: 10))
        .startWith(null)
        .flatMap((_) => createSource()),
    retryWhen,
  );
}
