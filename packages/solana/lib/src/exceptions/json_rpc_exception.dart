import 'package:json_annotation/json_annotation.dart';

part 'json_rpc_exception.g.dart';

abstract class JsonRpcErrorCode {
  static const blockCleanedUp = -32001;
  static const sendTransactionPreflightFailure = -32002;
  static const transactionSignatureVerificationFailure = -32003;
  static const blockNotAvailable = -32004;
  static const nodeUnhealthy = -32005;
  static const transactionPrecompileVerificationFailure = -32006;
  static const slotSkipped = -32007;
  static const noSnapshot = -32008;
  static const longTermStorageSlotSkipped = -32009;
  static const keyExcludedFromSecondaryIndex = -32010;
  static const transactionHistoryNotAvailable = -32011;
  static const scanError = -32012;
  static const transactionSignatureLenMismatch = -32013;
  static const blockStatusNotAvailableYet = -32014;
  static const unsupportedTransactionVersion = -32015;
  static const minContextSlotNotReached = -32016;
}

@JsonSerializable(createToJson: false)
class JsonRpcException implements Exception {
  const JsonRpcException(this.message, this.code, this.data);

  factory JsonRpcException.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcExceptionFromJson(json);

  final String message;
  final int code;

  // FIXME: data can be structured
  final dynamic data;

  TransactionError? get transactionError {
    final data = this.data;
    if (data is Map<String, dynamic>) {
      try {
        return _TransactionErrorData.fromJson(data).err;
      } on Object {
        return null;
      }
    }

    return null;
  }

  @override
  String toString() => data != null
      ? 'jsonrpc-2.0 error ($code): $message\n\t$data'
      : 'jsonrpc-2.0 error ($code): $message';
}

@JsonEnum(fieldRename: FieldRename.pascal)
enum TransactionError {
  /// An account is already being processed in another transaction in a way that
  /// does not support parallelism
  accountInUse,

  /// A `Pubkey` appears twice in the transaction’s `account_keys`. Instructions
  /// can reference `Pubkey`s more than once but the message must contain a list
  /// with no duplicate keys.
  accountLoadedTwice,

  /// Attempt to debit an account but found no record of a prior credit.
  accountNotFound,

  /// Attempt to load a program that does not exist.
  programAccountNotFound,

  /// The from `Pubkey` does not have sufficient balance to pay the fee to
  /// schedule the transaction.
  insufficientFundsForFee,

  /// This account may not be used to pay transaction fees.
  invalidAccountForFee,

  /// The bank has seen this transaction before. This can occur under normal
  /// operation when a UDP packet is duplicated, as a user error from a client
  /// not updating its `recent_blockhash`, or as a double-spend attack.
  alreadyProcessed,

  /// The bank has not seen the given `recent_blockhash` or the transaction is
  /// too old and the `recent_blockhash` has been discarded.
  blockhashNotFound,

  /// An error occurred while processing an instruction.
  instructionError,

  /// Loader call chain is too deep.
  callChainTooDeep,

  /// Transaction requires a fee but has no signature present.
  missingSignatureForFee,

  /// Transaction contains an invalid account reference.
  invalidAccountIndex,

  /// Transaction did not pass signature verification.
  signatureFailure,

  /// This program may not be used for executing instructions.
  invalidProgramForExecution,

  /// Transaction failed to sanitize accounts offsets correctly implies that
  /// account locks are not taken for this TX, and should not be unlocked.
  sanitizeFailure,

  clusterMaintenance,

  /// Transaction processing left an account with an outstanding borrowed
  /// reference.
  accountBorrowOutstanding,

  /// Unknown error.
  other,
}

@JsonSerializable(createToJson: false)
class _TransactionErrorData {
  const _TransactionErrorData(this.err);

  factory _TransactionErrorData.fromJson(Map<String, dynamic> json) =>
      _$TransactionErrorDataFromJson(json);

  @JsonKey(unknownEnumValue: TransactionError.other)
  final TransactionError err;
}
