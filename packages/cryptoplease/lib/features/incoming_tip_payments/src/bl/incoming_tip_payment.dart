import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'incoming_tip_payment.freezed.dart';

@freezed
class IncomingTipPayment with _$IncomingTipPayment {
  const factory IncomingTipPayment({
    required String id,
    required DateTime created,
    required Ed25519HDKeyPair escrow,
    required ITStatus status,
  }) = _IncomingTipPayment;
}

@freezed
class ITStatus with _$ITStatus {
  /// Private key is successfully retrieved from the URL.
  ///
  /// Private key is restored and the payment is ready to be claimed.
  const factory ITStatus.privateKeyReady() = ITStatusPrivateKeyReady;

  /// Tx is successfully created and ready to be sent.
  const factory ITStatus.txCreated(SignedTx tx) = ITStatusTxCreated;

  /// Tx is successfully sent.
  const factory ITStatus.txSent(SignedTx tx) = ITStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory ITStatus.success(SignedTx tx) = ITStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory ITStatus.txFailure() = ITStatusTxFailure;

  /// Failed to send the tx, waiting should be retried.
  const factory ITStatus.txSendFailure(SignedTx tx) = ITStatusTxSendFailure;

  /// Failed to get the confirmation about tx, waiting should be retried.
  const factory ITStatus.txWaitFailure(SignedTx tx) = ITStatusTxWaitFailure;

  /// Final state. Tx is failed to be confirmed and payment could not be claimed
  /// either due to invalid link or it was already claimed by someone else.
  const factory ITStatus.txEscrowFailure() = ITStatusTxEscrowFailure;
}
