import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'oskp_cancel.freezed.dart';

@freezed
class OSKPCancel with _$OSKPCancel {
  const factory OSKPCancel({
    required String oskpId,
    required DateTime created,
    required Ed25519HDKeyPair escrow,
    required OSKPCancelStatus status,
  }) = _OSKPCancel;
}

@freezed
class OSKPCancelStatus with _$OSKPCancelStatus {
  /// Tx is successfully created and ready to be sent.
  const factory OSKPCancelStatus.txCreated(SignedTx tx) =
      OSKPCancelStatusTxCreated;

  /// Tx is successfully sent.
  const factory OSKPCancelStatus.txSent(SignedTx tx) = OSKPCancelStatusTxSent;

  /// Final state. Tx is successfully confirmed and payment is claimed.
  const factory OSKPCancelStatus.success({required String txId}) =
      OSKPCancelStatusSuccess;

  /// Failed to create the tx, a new tx should be created.
  const factory OSKPCancelStatus.txFailure() = OSKPCancelStatusTxFailure;

  /// Failed to send the tx, waiting should be retried.
  const factory OSKPCancelStatus.txSendFailure(SignedTx tx) =
      OSKPCancelStatusTxSendFailure;

  /// Failed to get the confirmation about tx, waiting should be retried.
  const factory OSKPCancelStatus.txWaitFailure(SignedTx tx) =
      OSKPCancelStatusTxWaitFailure;

  /// Final state. Tx is failed to be confirmed and payment could not be claimed
  /// because it was already claimed by someone else.
  const factory OSKPCancelStatus.txEscrowFailure() =
      OSKPCancelStatusTxEscrowFailure;
}
