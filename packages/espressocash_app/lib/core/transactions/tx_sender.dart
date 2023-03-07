import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../config.dart';

part 'tx_sender.freezed.dart';

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
    } on JsonRpcException catch (e) {
      if (e.code == JsonRpcErrorCode.minContextSlotNotReached) {
        return const TxSendResult.networkError();
      }

      if (e.isInsufficientFunds) {
        return const TxSendResult.failure(
          reason: TxFailureReason.insufficientFunds,
        );
      }
      switch (e.transactionError) {
        case TransactionError.alreadyProcessed:
          return const TxSendResult.sent();
        case TransactionError.blockhashNotFound:
          return checkSubmittedTx(tx.id);
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
  }) async {
    try {
      final statuses = await _client.rpcClient
          .getSignatureStatuses([tx.id], searchTransactionHistory: true);
      final t = statuses.value.first;

      if (t == null) {
        final bh = tx.blockhash;
        final isValidBlockhash = await _client.rpcClient
            .isBlockhashValid(
              bh,
              commitment: Commitment.confirmed,
              minContextSlot: minContextSlot.toInt(),
            )
            .value;
        if (!isValidBlockhash && statuses.context.slot >= minContextSlot) {
          return const TxWaitResult.failure(
            reason: TxFailureReason.invalidBlockhashWaiting,
          );
        }
      } else {
        if (t.err != null) {
          return const TxWaitResult.failure(reason: TxFailureReason.txError);
        }

        if (t.confirmationStatus.index >= ConfirmationStatus.confirmed.index) {
          return const TxWaitResult.success();
        }
      }

      await _client.waitForSignatureStatus(
        tx.id,
        status: Commitment.confirmed,
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
}

// TODO(KB): should be removed after full migration to waiting status with
// SignedTx
class StubSignedTx implements SignedTx {
  StubSignedTx(this.id);

  @override
  String get blockhash => base58encode(List.filled(32, 0));

  @override
  String encode() => throw UnimplementedError();

  @override
  final String id;

  @override
  ByteArray toByteArray() => throw UnimplementedError();

  @override
  TransactionVersion get version => throw UnimplementedError();

  @override
  $SignedTxCopyWith<SignedTx> get copyWith => throw UnimplementedError();

  @override
  Message decompileMessage({
    List<AddressLookupTableAccount> addressLookupTableAccounts = const [],
  }) {
    throw UnimplementedError();
  }

  @override
  CompiledMessage get compiledMessage => throw UnimplementedError();

  @override
  List<Signature> get signatures => throw UnimplementedError();
}

@freezed
class TxSendResult with _$TxSendResult {
  const factory TxSendResult.sent() = TxSendSent;
  const factory TxSendResult.invalidBlockhash() = TxSendInvalidBlockhash;
  const factory TxSendResult.failure({
    required TxFailureReason reason,
  }) = TxSendFailure;
  const factory TxSendResult.networkError() = TxSendNetworkError;
}

@freezed
class TxWaitResult with _$TxWaitResult {
  const factory TxWaitResult.success() = TxWaitSuccess;
  const factory TxWaitResult.failure({
    required TxFailureReason reason,
  }) = TxWaitFailure;
  const factory TxWaitResult.networkError() = TxWaitNetworkError;
}

enum TxFailureReason {
  insufficientFunds,
  invalidBlockhashSending,
  invalidBlockhashWaiting,
  creatingFailure,
  txError,
  unknown,
  escrowFailure,
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
