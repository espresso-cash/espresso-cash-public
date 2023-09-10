import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import '../../../../core/amount.dart';
import '../../../transactions/models/tx_sender.dart';

part 'off_ramp_payment.freezed.dart';

@freezed
class OffRampPayment with _$OffRampPayment {
  const factory OffRampPayment.signTransaction({
    required String id,
    required String provider,
    required CryptoAmount amount,
    required DateTime created,
    required ORPStatus status,
  }) = ORPSignTransaction;
}

@Freezed(map: FreezedMapOptions.none, when: FreezedWhenOptions.none)
sealed class ORPStatus with _$ORPStatus {
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

  /// Money is received by the recipient address.
  const factory ORPStatus.success({required SignedTx tx}) = ORPStatusSuccess;

  /// Fiat Money is received by the user.
  const factory ORPStatus.withdrawn({
    required SignedTx tx,
    required DateTime timestamp,
  }) = ORPStatusWithdrawn;

  /// There was an error while creating the tx, or the tx was rejected. In any
  /// case, it's safe to recreate the tx.
  const factory ORPStatus.txFailure(
    SignedTx tx, {
    required TxFailureReason reason,
  }) = ORPStatusTxFailure;
}
