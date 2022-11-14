import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

part 'swap.freezed.dart';

@freezed
class Swap with _$Swap {
  const factory Swap({
    required String id,
    required DateTime created,
    required SwapStatus status,
  }) = _Swap;
}

@freezed
class SwapStatus with _$SwapStatus {
  /// Tx is successfully created and ready to be sent.
  const factory SwapStatus.txCreated(SignedTx tx) = SwapStatusTxCreated;

  /// Tx is successfully sent.
  const factory SwapStatus.txSent(SignedTx tx) = SwapStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory SwapStatus.success({required String txId}) = SwapStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory SwapStatus.txFailure() = SwapStatusTxFailure;

  /// Failed to send the tx, waiting should be retried.
  const factory SwapStatus.txSendFailure(SignedTx tx) = SwapStatusTxSendFailure;

  /// Failed to get the confirmation about tx, waiting should be retried.
  const factory SwapStatus.txWaitFailure(SignedTx tx) = SwapStatusTxWaitFailure;
}
