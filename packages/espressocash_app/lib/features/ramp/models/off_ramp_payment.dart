import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../core/amount.dart';
import '../../../core/transactions/tx_sender.dart';

part 'off_ramp_payment.freezed.dart';

@freezed
class OffRampPayment with _$OffRampPayment {
  const factory OffRampPayment({
    required String id,
    required Ed25519HDPublicKey receiver,
    required CryptoAmount amount,
    required DateTime created,
    required ORPStatus status,
  }) = _OffRampPayment;
}

@freezed
class ORPStatus with _$ORPStatus {
  /// Tx created, but not sent yet. At this stage, it's safe to recreate it.
  const factory ORPStatus.txCreated(
    SignedTx tx, {
    required BigInt slot,
  }) = ORPStatusTxCreated;

  /// Tx sent, but not confirmed yet. We cannot say if it was accepted.
  const factory ORPStatus.txSent(
    SignedTx tx, {
    required BigInt slot,
  }) = ORPStatusTxSent;

  /// Money is received by the recipient address. The payment is complete.
  const factory ORPStatus.success({required String txId}) = ORPStatusSuccess;

  /// There was an error while creating the tx, or the tx was rejected. In any
  /// case, it's safe to recreate the tx.
  const factory ORPStatus.txFailure({TxFailureReason? reason}) =
      ORPStatusTxFailure;
}
