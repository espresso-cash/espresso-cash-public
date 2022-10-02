import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

part 'incoming_split_key_payment.freezed.dart';

@freezed
class IncomingSplitKeyPayment with _$IncomingSplitKeyPayment {
  const factory IncomingSplitKeyPayment({
    required String id,
    required DateTime created,
    required ISKPStatus status,
  }) = _IncomingSplitKeyPayment;
}

@freezed
class ISKPStatus with _$ISKPStatus {
  /// First part of the key is successfully retrieved from the URL.
  const factory ISKPStatus.firstPartReady(String firstPart) =
      ISKPStatusFirstPartReady;

  /// Both parts of the key are successfully retrieved from the URL.
  ///
  /// Private key is restored and the payment is ready to be claimed.
  const factory ISKPStatus.privateKeyReady(List<int> privateKey) =
      ISKPStatusPrivateKeyReady;

  /// Tx is successfully created and ready to be sent.
  const factory ISKPStatus.txCreated(
    SignedTx tx, {
    required IList<int> privateKey,
  }) = ISKPStatusTxCreated;

  /// Tx is successfully sent.
  const factory ISKPStatus.txSent(
    String txId, {
    required List<int> privateKey,
  }) = ISKPStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory ISKPStatus.success() = ISKPStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory ISKPStatus.txFailure({
    required IList<int> privateKey,
  }) = ISKPStatusTxFailure;

  /// Failed to get the confirmation about tx, waiting should be retried.
  const factory ISKPStatus.txWaitFailure(
    String txId, {
    required List<int> privateKey,
  }) = ISKPStatusTxWaitFailure;

  /// Final state. Tx is failed to be confirmed and payment could not be claimed
  /// either due to invalid links or it was already claimed by someone else.
  const factory ISKPStatus.txEscrowFailure() = ISKPStatusTxEscrowFailure;
}
