import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';

part 'tx_results.freezed.dart';

// TODO(KB): should be removed after full migration to waiting status with
// SignedTx
class StubSignedTx implements SignedTx {
  const StubSignedTx(this.id);

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
sealed class TxSendResult with _$TxSendResult {
  const factory TxSendResult.sent() = TxSendSent;
  const factory TxSendResult.invalidBlockhash() = TxSendInvalidBlockhash;
  const factory TxSendResult.failure({
    required TxFailureReason reason,
  }) = TxSendFailure;
  const factory TxSendResult.networkError() = TxSendNetworkError;
}

@freezed
sealed class TxWaitResult with _$TxWaitResult {
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
