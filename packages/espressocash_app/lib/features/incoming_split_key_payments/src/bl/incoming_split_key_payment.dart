import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

import '../../../../core/api_version.dart';
import '../../../../core/escrow_private_key.dart';
import '../../../../core/transactions/tx_sender.dart';

part 'incoming_split_key_payment.freezed.dart';

@freezed
class IncomingSplitKeyPayment with _$IncomingSplitKeyPayment {
  const factory IncomingSplitKeyPayment({
    required String id,
    required DateTime created,
    required EscrowPrivateKey escrow,
    required ISKPStatus status,
    required SplitKeyApiVersion apiVersion,
  }) = _IncomingSplitKeyPayment;
}

@freezed
class ISKPStatus with _$ISKPStatus {
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
