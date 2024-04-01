import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../currency/models/amount.dart';
import '../../transactions/models/tx_results.dart';

part 'outgoing_direct_payment.freezed.dart';

@freezed
class OutgoingDirectPayment with _$OutgoingDirectPayment {
  const factory OutgoingDirectPayment({
    required String id,
    required Ed25519HDPublicKey receiver,
    required CryptoAmount amount,
    required DateTime created,
    required ODPStatus status,
    Ed25519HDPublicKey? reference,
  }) = _OutgoingDirectPayment;
}

@freezed
sealed class ODPStatus with _$ODPStatus {
  /// Tx created, but not sent yet. At this stage, it's safe to recreate it.
  const factory ODPStatus.txCreated(
    SignedTx tx, {
    required BigInt slot,
  }) = ODPStatusTxCreated;

  /// Tx sent, but not confirmed yet. We cannot say if it was accepted.
  const factory ODPStatus.txSent(
    SignedTx tx, {
    required BigInt slot,
  }) = ODPStatusTxSent;

  /// Money is received by the recipient address. The payment is complete.
  const factory ODPStatus.success({required String txId}) = ODPStatusSuccess;

  /// There was an error while creating the tx, or the tx was rejected. In any
  /// case, it's safe to recreate the tx.
  const factory ODPStatus.txFailure({TxFailureReason? reason}) =
      ODPStatusTxFailure;
}

extension OutgoingDirectPaymentExt on OutgoingDirectPayment {
  bool get isRetriable => status is ODPStatusTxFailure;
}
