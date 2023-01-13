import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'cancel_outgoing_payment.freezed.dart';

@freezed
class CancelOutgoingPayment with _$CancelOutgoingPayment {
  const factory CancelOutgoingPayment({
    required String paymentId,
    required DateTime created,
    required Ed25519HDKeyPair escrow,
    required COPStatus status,
  }) = _CancelOutgoingPayment;
}

@freezed
class COPStatus with _$COPStatus {
  /// Tx is successfully created and ready to be sent.
  const factory COPStatus.txCreated(SignedTx tx) = COPStatusTxCreated;

  /// Tx is successfully sent.
  const factory COPStatus.txSent(SignedTx tx) = COPStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory COPStatus.success({required String txId}) = COPStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory COPStatus.txFailure() = COPStatusTxFailure;

  /// Failed to send the tx, waiting should be retried.
  const factory COPStatus.txSendFailure(SignedTx tx) = COPStatusTxSendFailure;

  /// Failed to get the confirmation about tx, waiting should be retried.
  const factory COPStatus.txWaitFailure(SignedTx tx) = COPStatusTxWaitFailure;

  /// Final state. Tx is failed to be confirmed and payment could not be claimed
  /// because it was already claimed by someone else.
  const factory COPStatus.txEscrowFailure() = COPStatusTxEscrowFailure;
}
