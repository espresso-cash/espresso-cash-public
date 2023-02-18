import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../core/transactions/tx_sender.dart';

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
  const factory ISKPStatus.txCreated(
    SignedTx tx, {
    required BigInt slot,
  }) = ISKPStatusTxCreated;

  /// Tx is successfully sent.
  const factory ISKPStatus.txSent(
    SignedTx tx, {
    required BigInt slot,
  }) = ISKPStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory ISKPStatus.success({required String txId}) = ISKPStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory ISKPStatus.txFailure({
    required TxFailureReason reason,
  }) = ISKPStatusTxFailure;
}
