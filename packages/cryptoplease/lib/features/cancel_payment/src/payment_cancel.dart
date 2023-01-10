import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'payment_cancel.freezed.dart';

@freezed
class PaymentCancel with _$PaymentCancel {
  const factory PaymentCancel({
    required String paymentId,
    required DateTime created,
    required Ed25519HDKeyPair escrow,
    required PaymentCancelStatus status,
  }) = _PaymentCancel;
}

@freezed
class PaymentCancelStatus with _$PaymentCancelStatus {
  /// Tx is successfully created and ready to be sent.
  const factory PaymentCancelStatus.txCreated(SignedTx tx) =
      PaymentCancelStatusTxCreated;

  /// Tx is successfully sent.
  const factory PaymentCancelStatus.txSent(SignedTx tx) =
      PaymentCancelStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory PaymentCancelStatus.success({required String txId}) =
      PaymentCancelStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory PaymentCancelStatus.txFailure() = PaymentCancelStatusTxFailure;

  /// Failed to send the tx, waiting should be retried.
  const factory PaymentCancelStatus.txSendFailure(SignedTx tx) =
      PaymentCancelStatusTxSendFailure;

  /// Failed to get the confirmation about tx, waiting should be retried.
  const factory PaymentCancelStatus.txWaitFailure(SignedTx tx) =
      PaymentCancelStatusTxWaitFailure;

  /// Final state. Tx is failed to be confirmed and payment could not be claimed
  /// because it was already claimed by someone else.
  const factory PaymentCancelStatus.txEscrowFailure() =
      PaymentCancelStatusTxEscrowFailure;
}
