import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../core/amount.dart';
import '../../../../core/transactions/tx_sender.dart';

part 'outgoing_tip_payment.freezed.dart';

@freezed
class OutgoingTipPayment with _$OutgoingTipPayment {
  const factory OutgoingTipPayment({
    required String id,
    required CryptoAmount amount,
    required DateTime created,
    required OTStatus status,
  }) = _OutgoingTipPayment;

  const OutgoingTipPayment._();

  bool get shouldRetry => status.maybeMap(
        txFailure: T,
        txSendFailure: T,
        txWaitFailure: T,
        txLinksFailure: T,
        orElse: F,
      );
}

@freezed
class OTStatus with _$OTStatus {
  const factory OTStatus.txCreated(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OTTxCreated;

  const factory OTStatus.txSent(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OTTxSent;

  const factory OTStatus.txConfirmed({
    required Ed25519HDKeyPair escrow,
  }) = OTTxConfirmed;

  const factory OTStatus.linkReady({
    required Uri link,
    required Ed25519HDKeyPair escrow,
  }) = OTLinkReady;

  const factory OTStatus.withdrawn({
    required String txId,
  }) = OTWithdrawn;

  const factory OTStatus.canceled({
    required String txId,
  }) = OTCanceled;

  const factory OTStatus.txFailure({TxFailureReason? reason}) = OTTxFailure;

  const factory OTStatus.txSendFailure(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OTTxSendFailure;

  const factory OTStatus.txWaitFailure(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OTTxWaitFailure;

  const factory OTStatus.txLinksFailure({
    required Ed25519HDKeyPair escrow,
  }) = OTTxLinksFailure;

  const factory OTStatus.cancelTxCreated(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OTStatusCancelTxCreated;

  const factory OTStatus.cancelTxFailure({
    TxFailureReason? reason,
    required Ed25519HDKeyPair escrow,
  }) = OTStatusCancelTxFailure;

  const factory OTStatus.cancelTxSent(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OTStatusCancelTxSent;

  const factory OTStatus.cancelTxSendFailure(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OTStatusCancelTxSendFailure;

  const factory OTStatus.cancelTxWaitFailure(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OTStatusCancelTxWaitFailure;
}
