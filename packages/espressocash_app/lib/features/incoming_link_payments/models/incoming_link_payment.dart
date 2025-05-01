import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

import '../../currency/models/amount.dart';
import '../../escrow/models/escrow_private_key.dart';
import '../../transactions/models/tx_results.dart';

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
sealed class ILPStatus with _$ILPStatus {
  /// Tx is successfully created and ready to be sent.
  const factory ILPStatus.txCreated(SignedTx tx, {required BigInt slot}) = ILPStatusTxCreated;

  /// Tx is successfully sent.
  const factory ILPStatus.txSent(SignedTx tx, {required BigInt slot, required CryptoAmount? fee}) =
      ILPStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory ILPStatus.success({
    required SignedTx tx,
    required CryptoAmount? fee,
    required CryptoAmount? receiveAmount,
  }) = ILPStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory ILPStatus.txFailure({required TxFailureReason reason}) = ILPStatusTxFailure;
}
