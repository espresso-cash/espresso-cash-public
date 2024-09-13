import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

import '../../currency/models/amount.dart';
import '../../escrow/models/escrow_private_key.dart';
import '../../transactions/models/tx_results.dart';

part 'outgoing_link_payment.freezed.dart';

@freezed
class OutgoingLinkPayment with _$OutgoingLinkPayment {
  const factory OutgoingLinkPayment({
    required String id,
    required CryptoAmount amount,
    required DateTime created,
    required OLPStatus status,
    DateTime? linksGeneratedAt,
  }) = _OutgoingLinkPayment;

  const OutgoingLinkPayment._();
}

@freezed
class OLPStatus with _$OLPStatus {
  /// Tx created, but not sent yet. At this stage, it's safe to cancel it.
  const factory OLPStatus.txCreated(
    SignedTx tx, {
    required EscrowPrivateKey escrow,
  }) = OLPStatusTxCreated;

  /// Tx sent sent to backend. Should be good as confirmed at this point
  const factory OLPStatus.txSent(
    SignedTx tx, {
    required EscrowPrivateKey escrow,
    required String signature,
  }) = OLPStatusTxSent;

  /// Link is ready to be sent to the recipient.
  const factory OLPStatus.linkReady({
    required Uri link,
    required EscrowPrivateKey escrow,
  }) = OLPStatusLinkReady;

  /// Money are withdrawn from the escrow by someone, but not by the sender. The
  /// payment is complete.
  const factory OLPStatus.withdrawn({
    required String txId,
    required DateTime? timestamp,
  }) = OLPStatusWithdrawn;

  /// Money are withdrawn by the sender. The payment is complete.
  const factory OLPStatus.canceled({
    required String? txId,
    required DateTime? timestamp,
  }) = OLPStatusCanceled;

  /// There was an error while creating the tx, or the tx was rejected. In any
  /// case, it's safe to recreate the tx or directly cancel the payment.
  const factory OLPStatus.txFailure({required TxFailureReason reason}) =
      OLPStatusTxFailure;

  /// Cancellation tx was created but not sent yet
  const factory OLPStatus.cancelTxCreated(
    SignedTx tx, {
    required EscrowPrivateKey escrow,
  }) = OLPStatusCancelTxCreated;

  /// There was an error while creating the cancellation tx, or the tx was
  /// rejected. It's safe to recreate it.
  const factory OLPStatus.cancelTxFailure({
    required TxFailureReason reason,
    required EscrowPrivateKey escrow,
  }) = OLPStatusCancelTxFailure;

  /// Cancellation tx was sent but not confirmed yet. It's not safe to recreate
  /// it, we need to know the final status.
  const factory OLPStatus.cancelTxSent(
    SignedTx tx, {
    required EscrowPrivateKey escrow,
    required String signature,
  }) = OLPStatusCancelTxSent;
}
