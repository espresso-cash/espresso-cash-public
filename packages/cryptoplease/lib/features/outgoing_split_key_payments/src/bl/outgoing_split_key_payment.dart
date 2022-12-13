import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../core/amount.dart';
import '../../../../core/transactions/tx_sender.dart';

part 'outgoing_split_key_payment.freezed.dart';

@freezed
class OutgoingSplitKeyPayment with _$OutgoingSplitKeyPayment {
  const factory OutgoingSplitKeyPayment({
    required String id,
    required CryptoAmount amount,
    required DateTime created,
    required OSKPStatus status,
  }) = _OutgoingSplitKeyPayment;

  const OutgoingSplitKeyPayment._();

  bool get shouldRetry => status.maybeMap(
        txFailure: T,
        txSendFailure: T,
        txWaitFailure: T,
        txLinksFailure: T,
        orElse: F,
      );
}

@freezed
class OSKPStatus with _$OSKPStatus {
  const factory OSKPStatus.txCreated(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OSKPStatusTxCreated;

  const factory OSKPStatus.txSent(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OSKPStatusTxSent;

  const factory OSKPStatus.txConfirmed({
    required Ed25519HDKeyPair escrow,
  }) = OSKPStatusTxConfirmed;

  const factory OSKPStatus.linksReady({
    required Uri link1,
    required Uri link2,
    required Ed25519HDKeyPair escrow,
  }) = OSKPStatusLinksReady;

  const factory OSKPStatus.success({
    required String escrowTxId,
    required String withdrawTxId,
  }) = OSKPStatusSuccess;

  const factory OSKPStatus.txFailure({TxFailureReason? reason}) =
      OSKPStatusTxFailure;

  const factory OSKPStatus.txSendFailure(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OSKPStatusTxSendFailure;

  const factory OSKPStatus.txWaitFailure(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) = OSKPStatusTxWaitFailure;

  const factory OSKPStatus.txLinksFailure({
    required Ed25519HDKeyPair escrow,
  }) = OSKPStatusTxLinksFailure;
}
