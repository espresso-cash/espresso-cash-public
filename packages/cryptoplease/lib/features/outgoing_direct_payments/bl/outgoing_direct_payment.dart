import 'package:cryptoplease/core/amount.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'outgoing_direct_payment.freezed.dart';

@freezed
class OutgoingDirectPayment with _$OutgoingDirectPayment {
  const factory OutgoingDirectPayment({
    required String id,
    required Ed25519HDPublicKey receiver,
    required CryptoAmount amount,
    required DateTime created,
    required ODPStatus status,
  }) = _OutgoingDirectPayment;
}

@freezed
class ODPStatus with _$ODPStatus {
  const factory ODPStatus.txCreated(SignedTx tx) = ODPStatusTxCreated;
  const factory ODPStatus.txSent(String txId) = ODPStatusTxSent;
  const factory ODPStatus.success({required String txId}) = ODPStatusSuccess;
  const factory ODPStatus.txFailure() = ODPStatusTxFailure;
  const factory ODPStatus.txSendFailure(SignedTx tx) = ODPStatusTxSendFailure;
  const factory ODPStatus.txWaitFailure(String txId) = ODPStatusTxWaitFailure;
}
