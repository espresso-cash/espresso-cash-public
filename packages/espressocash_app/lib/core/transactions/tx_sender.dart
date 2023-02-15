import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/dto.dart';
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
    Future<TxSendResult> checkSubmittedTx(String txId) => _client.rpcClient
        .getSignatureStatuses([txId], searchTransactionHistory: true)
        .value
        .then(
          (value) => value.first == null
              ? const TxSendResult.invalidBlockhash()
              : const TxSendResult.sent(),
          onError: (_) => const TxSendResult.networkError(),
        );

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
          return checkSubmittedTx(tx.id);
        default:
          return const TxSendResult.failure(reason: TxFailureReason.txError);
      }
    } on Exception {
      return const TxSendResult.networkError();
    }
  }

  Future<TxWaitResult> wait(SignedTx tx) async {
    try {
      final t = await _client.rpcClient
          .getSignatureStatuses([tx.id], searchTransactionHistory: true)
          .value
          .then((value) => value.first);

      if (t == null) {
        // TODO(KB): There is currently a bug if the RPC node reports that
        // blockhash is invalid, but the transaction was actually submitted.
        final bh = tx.blockhash;
        final isValidBlockhash = await _client.rpcClient
            .isBlockhashValid(bh, commitment: Commitment.confirmed)
            .value;
        if (!isValidBlockhash) {
          // Check once more to ensure that the transaction was not submitted
          // while we were checking blockhash.
          final wasSubmitted = await _client.rpcClient
              .getSignatureStatuses([tx.id], searchTransactionHistory: true)
              .value
              .then((it) => it.first != null);

          if (!wasSubmitted) {
            return const TxWaitResult.failure(
              reason: TxFailureReason.invalidBlockhashWaiting,
            );
          }
        }
      } else {
        if (t.err != null) {
          return const TxWaitResult.failure(reason: TxFailureReason.txError);
        }

        if (t.confirmationStatus.index >= ConfirmationStatus.confirmed.index) {
          return const TxWaitResult.success();
        }
      }

      await _client.waitForSignatureStatus(tx.id, status: Commitment.confirmed);

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
