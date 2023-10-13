import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

import '../../../core/escrow_private_key.dart';
import '../../transactions/models/tx_sender.dart';

part 'incoming_link_payment.freezed.dart';

@freezed
class IncomingLinkPayment with _$IncomingLinkPayment {
  const factory IncomingLinkPayment({
    required String id,
    required DateTime created,
    required EscrowPrivateKey escrow,
    required ILPStatus status,
  }) = _IncomingLinkPayment;
}

@freezed
class ILPStatus with _$ILPStatus {
  /// Tx is successfully created and ready to be sent.
  const factory ILPStatus.txCreated(
    SignedTx tx, {
    required BigInt slot,
  }) = ILPStatusTxCreated;

  /// Tx is successfully sent.
  const factory ILPStatus.txSent(
    SignedTx tx, {
    required BigInt slot,
  }) = ILPStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory ILPStatus.success({required String txId}) = ILPStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory ILPStatus.txFailure({
    required TxFailureReason reason,
  }) = ILPStatusTxFailure;
}
