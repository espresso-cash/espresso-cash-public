import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

part 'cancel_outgoing_payment.freezed.dart';

@freezed
class CancelStatus with _$CancelStatus {
  /// Tx is successfully created and ready to be sent.
  const factory CancelStatus.txCreated(SignedTx tx) = CancelStatusTxCreated;

  /// Tx is successfully sent.
  const factory CancelStatus.txSent(SignedTx tx) = CancelStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory CancelStatus.success({required String txId}) =
      CancelStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory CancelStatus.txFailure() = CancelStatusTxFailure;

  /// Failed to send the tx, waiting should be retried.
  const factory CancelStatus.txSendFailure(SignedTx tx) =
      CancelStatusTxSendFailure;

  /// Failed to get the confirmation about tx, waiting should be retried.
  const factory CancelStatus.txWaitFailure(SignedTx tx) =
      CancelStatusTxWaitFailure;

  /// Final state. Tx is failed to be confirmed and payment could not be claimed
  /// because it was already claimed by someone else.
  const factory CancelStatus.txEscrowFailure() = CancelStatusTxEscrowFailure;
}
