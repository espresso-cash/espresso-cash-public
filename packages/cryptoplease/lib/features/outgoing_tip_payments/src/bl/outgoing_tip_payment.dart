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
    required OutgoingTipStatus status,
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
class OutgoingTipStatus with _$OutgoingTipStatus {
  const factory OutgoingTipStatus.txCreated(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OutgoingTipTxCreated;

  const factory OutgoingTipStatus.txSent(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OutgoingTipTxSent;

  const factory OutgoingTipStatus.txConfirmed({
    required Ed25519HDKeyPair escrow,
  }) = OutgoingTipTxConfirmed;

  const factory OutgoingTipStatus.linkReady({
    required Uri link,
    required Ed25519HDKeyPair escrow,
  }) = OutgoingTipLinkReady;

  const factory OutgoingTipStatus.success({
    required String txId,
  }) = OutgoingTipSuccess;

  const factory OutgoingTipStatus.txFailure({TxFailureReason? reason}) =
      OutgoingTipTxFailure;

  const factory OutgoingTipStatus.txSendFailure(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OutgoingTipTxSendFailure;

  const factory OutgoingTipStatus.txWaitFailure(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OutgoingTipTxWaitFailure;

  const factory OutgoingTipStatus.txLinksFailure({
    required Ed25519HDKeyPair escrow,
  }) = OutgoingTipTxLinksFailure;
}
