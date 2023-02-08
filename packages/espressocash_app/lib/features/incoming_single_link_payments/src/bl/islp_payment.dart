import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'islp_payment.freezed.dart';

@freezed
class IncomingSingleLinkPayment with _$IncomingSingleLinkPayment {
  const factory IncomingSingleLinkPayment({
    required String id,
    required DateTime created,
    required Ed25519HDKeyPair escrow,
    required ISLPStatus status,
  }) = _IncomingSingleLinkPayment;
}

@freezed
class ISLPStatus with _$ISLPStatus {
  /// Private key is successfully retrieved from the URL.
  ///
  /// Private key is restored and the payment is ready to be claimed.
  const factory ISLPStatus.privateKeyReady() = ISLPStatusPrivateKeyReady;

  /// Tx is successfully created and ready to be sent.
  const factory ISLPStatus.txCreated(SignedTx tx) = ISLPStatusTxCreated;

  /// Tx is successfully sent.
  const factory ISLPStatus.txSent(SignedTx tx) = ISLPStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory ISLPStatus.success({required String txId}) = ISLPStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory ISLPStatus.txFailure() = ISLPStatusTxFailure;

  /// Failed to send the tx, waiting should be retried.
  const factory ISLPStatus.txSendFailure(SignedTx tx) = ISLPStatusTxSendFailure;

  /// Failed to get the confirmation about tx, waiting should be retried.
  const factory ISLPStatus.txWaitFailure(SignedTx tx) = ISLPStatusTxWaitFailure;

  /// Final state. Tx is failed to be confirmed and payment could not be claimed
  /// either due to invalid link or it was already claimed by someone else.
  const factory ISLPStatus.txEscrowFailure() = ISLPStatusTxEscrowFailure;
}
