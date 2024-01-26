import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
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
      _logger.fine('${tx.id}: Checking tx status.');
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
        _logger.fine('${tx.id}: Tx not found.');

        // Blockhash is still valid, tx can be submitted.
        if (blockhashValidity.value) {
          _logger.fine('${tx.id}: Blockhash is still valid.');

          return null;
        }

        if (DateTime.now().difference(start).inSeconds > 90) {
          _logger.fine('${tx.id}: Timeout, failing.');

          // We've been waiting for too long, blockhash is invalid and it
          // won't be valid.
          return const TxWaitResult.failure(
            reason: TxFailureReason.invalidBlockhashWaiting,
          );
        }

        // No minContextSlot, it's not safe to assume that we get the latest
        // status.
        if (minContextSlot == BigInt.zero) {
          _logger.fine('${tx.id}: minContextSlot is zero.');

          return null;
        }

        // We were calling the status with too old slot, we cannot be sure
        // that tx was not submitted.
        if (statuses.context.slot < minContextSlot) {
          _logger.fine('${tx.id}: minContextSlot not reached.');

          return null;
        }

        // We were calling the status with too old slot, blockhash validity
        // is not guaranteed.
        if (statuses.context.slot < blockhashValidity.context.slot) {
          _logger.fine('${tx.id}: Blockhas validity slot is ahead.');

          return null;
        }

        _logger.fine('${tx.id}: Ivalid blockhash.');

        // At this stage, blockhash is invalid and it won't be valid, so
        // tx cannot be submitted.
        return const TxWaitResult.failure(
          reason: TxFailureReason.invalidBlockhashWaiting,
        );
      }

      if (t.err != null) {
        _logger.fine('${tx.id}: Tx error ${t.err}.');

        return const TxWaitResult.failure(reason: TxFailureReason.txError);
      }

      if (t.confirmationStatus.index >= ConfirmationStatus.confirmed.index) {
        _logger.fine('${tx.id}: Success.');

        return const TxWaitResult.success();
      }

      _logger
          .fine('${tx.id}: Wrong confirmation status ${t.confirmationStatus}.');
    }

    Future<TxWaitResult?> waitForSignatureStatus() async {
      try {
        await _client.waitForSignatureStatus(
          tx.id,
          status: commitment,
          pingInterval: pingDefaultInterval,
          timeout: waitForSignatureDefaultTimeout,
        );

        _logger.fine('${tx.id}: Success from WS.');

        return const TxWaitResult.success();
      } on SubscriptionClientException catch (error) {
        _logger.fine('${tx.id}: Failure from WS $error.');

        return const TxWaitResult.failure(reason: TxFailureReason.txError);
      } on Exception catch (error) {
        _logger.fine('${tx.id}: Network error from WS $error.');

        return null;
      }
    }

    final polling = Stream<void>.periodic(const Duration(seconds: 10))
        .startWith(null)
        .exhaustMap((_) => getSignatureStatus().asStream().onErrorReturn(null));

    return MergeStream([polling, waitForSignatureStatus().asStream()])
        .whereNotNull()
        .first;
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

final _logger = Logger('TxSender');
