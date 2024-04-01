import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

import '../../currency/models/amount.dart';
import '../../transactions/models/tx_results.dart';
import 'dln_payment.dart';

part 'outgoing_payment.freezed.dart';

@freezed
class OutgoingDlnPayment with _$OutgoingDlnPayment {
  const factory OutgoingDlnPayment({
    required String id,
    required CryptoAmount amount,
    required DateTime created,
    required OutgoingDlnPaymentStatus status,
    required DlnPayment payment,
  }) = _OutgoingDlnPayment;
}

@freezed
sealed class OutgoingDlnPaymentStatus with _$OutgoingDlnPaymentStatus {
  /// Tx is successfully created and ready to be sent.
  const factory OutgoingDlnPaymentStatus.txCreated(
    SignedTx tx, {
    required BigInt slot,
  }) = OutgoingDlnPaymentStatusTxCreated;

  /// Tx is successfully sent.
  const factory OutgoingDlnPaymentStatus.txSent(
    SignedTx tx, {
    required BigInt slot,
  }) = OutgoingDlnPaymentStatusTxSent;

  /// Tx is successfully confirmed and order awaiting fulfillment.
  const factory OutgoingDlnPaymentStatus.success(
    SignedTx tx, {
    required String? orderId,
  }) = OutgoingDlnPaymentStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory OutgoingDlnPaymentStatus.txFailure({
    required TxFailureReason reason,
  }) = OutgoingDlnPaymentStatusTxFailure;

  /// Order is fulfilled and funds are sent to the recipient.
  const factory OutgoingDlnPaymentStatus.fulfilled(
    SignedTx tx, {
    required String orderId,
  }) = OutgoingDlnPaymentStatusFulfilled;

  /// Order has been stale for some time and most likely wont be fulfilled.
  const factory OutgoingDlnPaymentStatus.unfulfilled(
    SignedTx tx, {
    required String orderId,
  }) = OutgoingDlnPaymentStatusUnFulfilled;
}
