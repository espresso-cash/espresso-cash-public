part of 'bloc.dart';

@freezed
class OutgoingTransferStatusState with _$OutgoingTransferStatusState {
  const factory OutgoingTransferStatusState({
    @Default(ProcessingStateNone()) ProcessingState processingState,
    OutgoingTransferStatus? transferStatus,
  }) = OutgoingTransferStatusStateOngoing;
}

@freezed
class Transaction with _$Transaction {
  const factory Transaction.generic({
    required Meta? meta,
    required DateTime? blockTime,
    required String hash,
  }) = GenericTransaction;

  const factory Transaction.transfer({
    required String hash,
    required String senderAddress,
    required String recipientAddress,
    required int amount,
    required DateTime? blockTime,
    Meta? meta,
  }) = TransferTransaction;
}
