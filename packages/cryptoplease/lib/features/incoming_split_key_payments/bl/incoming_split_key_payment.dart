import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'incoming_split_key_payment.freezed.dart';

@freezed
class IncomingSplitKeyPayment with _$IncomingSplitKeyPayment {
  const factory IncomingSplitKeyPayment({
    required String id,
    required DateTime created,
    required Ed25519HDKeyPair escrow,
    required ISKPStatus status,
  }) = _IncomingSplitKeyPayment;
}

@freezed
class ISKPStatus with _$ISKPStatus {
  /// Both parts of the key are successfully retrieved from the URL.
  ///
  /// Private key is restored and the payment is ready to be claimed.
  const factory ISKPStatus.privateKeyReady() = ISKPStatusPrivateKeyReady;

  /// Tx is successfully created and ready to be sent.
  const factory ISKPStatus.txCreated(SignedTx tx) = ISKPStatusTxCreated;

  /// Tx is successfully sent.
  const factory ISKPStatus.txSent(String txId) = ISKPStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory ISKPStatus.success() = ISKPStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory ISKPStatus.txFailure() = ISKPStatusTxFailure;

  /// Failed to send the tx, waiting should be retried.
  const factory ISKPStatus.txSendFailure(SignedTx tx) = ISKPStatusTxSendFailure;

  /// Failed to get the confirmation about tx, waiting should be retried.
  const factory ISKPStatus.txWaitFailure(String txId) = ISKPStatusTxWaitFailure;

  /// Final state. Tx is failed to be confirmed and payment could not be claimed
  /// either due to invalid links or it was already claimed by someone else.
  const factory ISKPStatus.txEscrowFailure() = ISKPStatusTxEscrowFailure;
}
