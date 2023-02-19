import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../core/escrow_private_key.dart';
import '../../../../core/transactions/tx_sender.dart';

part 'islp_payment.freezed.dart';

@freezed
class IncomingSingleLinkPayment with _$IncomingSingleLinkPayment {
  const factory IncomingSingleLinkPayment({
    required String id,
    required DateTime created,
    required EscrowPrivateKey escrow,
    required ISLPStatus status,
  }) = _IncomingSingleLinkPayment;
}

@freezed
class ISLPStatus with _$ISLPStatus {
  /// Tx is successfully created and ready to be sent.
  const factory ISLPStatus.txCreated(
    SignedTx tx, {
    required BigInt slot,
  }) = ISLPStatusTxCreated;

  /// Tx is successfully sent.
  const factory ISLPStatus.txSent(
    SignedTx tx, {
    required BigInt slot,
  }) = ISLPStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory ISLPStatus.success({required String txId}) = ISLPStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory ISLPStatus.txFailure({
    required TxFailureReason reason,
  }) = ISLPStatusTxFailure;
}
