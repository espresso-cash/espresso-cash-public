import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

import '../../../core/amount.dart';
import '../../../core/api_version.dart';
import '../../../core/escrow_private_key.dart';
import '../../../core/transactions/tx_sender.dart';

part 'outgoing_split_key_payment.freezed.dart';

@freezed
class OutgoingSplitKeyPayment with _$OutgoingSplitKeyPayment {
  const factory OutgoingSplitKeyPayment({
    required String id,
    required CryptoAmount amount,
    required DateTime created,
    required OSKPStatus status,
    required SplitKeyApiVersion apiVersion,
    DateTime? linksGeneratedAt,
  }) = _OutgoingSplitKeyPayment;

  const OutgoingSplitKeyPayment._();
}

@freezed
class OSKPStatus with _$OSKPStatus {
  /// Tx created, but not sent yet. At this stage, it's safe to cancel/recreate
  /// it.
  const factory OSKPStatus.txCreated(
    SignedTx tx, {
    required BigInt slot,
    required EscrowPrivateKey escrow,
  }) = OSKPStatusTxCreated;

  /// Tx sent, but not confirmed yet. We cannot say if it was accepted, so
  /// before canceling/recreating we need to know its status.
  const factory OSKPStatus.txSent(
    SignedTx tx, {
    required BigInt slot,
    required EscrowPrivateKey escrow,
  }) = OSKPStatusTxSent;

  /// Tx confirmed. At this stage, the money are guaranteed to be in the escrow.
  /// For canceling the payment, we need to create a new cancellation tx.
  const factory OSKPStatus.txConfirmed({
    required EscrowPrivateKey escrow,
  }) = OSKPStatusTxConfirmed;

  /// Links are ready to be sent to the recipient.
  const factory OSKPStatus.linksReady({
    required Uri link1,
    required Uri link2,
    required Uri? qrLink,
    required EscrowPrivateKey escrow,
  }) = OSKPStatusLinksReady;

  /// Money are withdrawn from the escrow by someone, but not by the sender. The
  /// payment is complete.
  const factory OSKPStatus.withdrawn({
    required String txId,
    required DateTime? timestamp,
  }) = OSKPStatusWithdrawn;

  /// Money are withdrawn by the sender. The payment is complete.
  const factory OSKPStatus.canceled({
    required String? txId,
    required DateTime? timestamp,
  }) = OSKPStatusCanceled;

  /// There was an error while creating the tx, or the tx was rejected. In any
  /// case, it's safe to recreate the tx or directly cancel the payment.
  const factory OSKPStatus.txFailure({required TxFailureReason reason}) =
      OSKPStatusTxFailure;

  /// Cancellation tx was created but not sent yet. It's safe to recreate the
  /// tx.
  const factory OSKPStatus.cancelTxCreated(
    SignedTx tx, {
    required BigInt slot,
    required EscrowPrivateKey escrow,
  }) = OSKPStatusCancelTxCreated;

  /// There was an error while creating the cancellation tx, or the tx was
  /// rejected. It's safe to recreate it.
  const factory OSKPStatus.cancelTxFailure({
    required TxFailureReason reason,
    required EscrowPrivateKey escrow,
  }) = OSKPStatusCancelTxFailure;

  /// Cancellation tx was sent but not confirmed yet. It's not safe to recreate
  /// it, we need to know the final status.
  const factory OSKPStatus.cancelTxSent(
    SignedTx tx, {
    required BigInt slot,
    required EscrowPrivateKey escrow,
  }) = OSKPStatusCancelTxSent;
}
